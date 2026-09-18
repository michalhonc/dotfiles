/**
 * Modes — MD skills loaded upfront, prior to the first prompt.
 *
 * Each mode is a markdown file with frontmatter (name, description, default,
 * order, skill) stored in the `modes/` directory next to this file.
 *
 * - `default: on` modes are active from session start — you can type right
 *   away and their bodies are prepended to your first message automatically.
 * - `skill: <path>` loads the body from an external SKILL.md (frontmatter
 *   stripped, `~` expanded). Any body in the mode file itself is included too.
 * - Press ctrl+q or run /modes to open the toggle menu (space: toggle,
 *   tab: preview, enter: apply, esc: cancel).
 * - Each enabled mode is injected exactly once per session (on the next
 *   message sent after it was enabled). Disabling an already-injected mode
 *   cannot retract it; tell the model to stop instead.
 */

import { existsSync, mkdirSync, readFileSync, readdirSync } from "node:fs";
import { homedir } from "node:os";
import { dirname, isAbsolute, join } from "node:path";
import { fileURLToPath } from "node:url";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { Key, matchesKey, truncateToWidth, wrapTextWithAnsi } from "@earendil-works/pi-tui";

interface Mode {
	/** Filename, e.g. "caveman.md" */
	id: string;
	name: string;
	description: string;
	defaultOn: boolean;
	order: number;
	/** Radio group name — at most one mode per group can be enabled. */
	group: string | null;
	/** Resolved skill path, if any (for display). */
	skillPath: string | null;
	body: string;
}

const extensionDir = dirname(fileURLToPath(import.meta.url));
const modesDir = join(extensionDir, "modes");
const WIDGET_ID = "modes";

function expandPath(p: string): string {
	if (p.startsWith("~/") || p === "~") return join(homedir(), p.slice(1));
	return isAbsolute(p) ? p : join(modesDir, p);
}

function stripFrontmatter(raw: string): string {
	const match = raw.match(/^---\r?\n[\s\S]*?\r?\n---\r?\n?([\s\S]*)$/);
	return (match ? match[1] : raw).trim();
}

function parseMode(filename: string, raw: string): Mode | null {
	const match = raw.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n?([\s\S]*)$/);
	if (!match) return null;

	const meta: Record<string, string> = {};
	for (const line of match[1].split(/\r?\n/)) {
		const kv = line.match(/^([A-Za-z][\w-]*)\s*:\s*(.*)$/);
		if (kv) meta[kv[1].toLowerCase()] = kv[2].trim().replace(/^["']|["']$/g, "");
	}

	const parts: string[] = [];
	let skillPath: string | null = null;

	if (meta.skill) {
		skillPath = expandPath(meta.skill);
		try {
			const skillRaw = readFileSync(skillPath, "utf8");
			const skillBody = stripFrontmatter(skillRaw);
			if (skillBody) {
				parts.push(
					`<skill from="${skillPath}">\n(Resolve any relative paths in this skill against ${dirname(skillPath)})\n\n${skillBody}\n</skill>`,
				);
			}
		} catch {
			// Skill file missing/unreadable; fall through to own body (if any).
		}
	}

	const ownBody = match[2].trim();
	if (ownBody) parts.push(ownBody);

	const body = parts.join("\n\n");
	if (!body) return null;

	const parsedOrder = Number.parseInt(meta.order ?? "", 10);
	return {
		id: filename,
		name: meta.name || filename.replace(/\.md$/i, ""),
		description: meta.description ?? "",
		defaultOn: /^(on|true|yes|1)$/i.test(meta.default ?? ""),
		order: Number.isFinite(parsedOrder) ? parsedOrder : 9999,
		group: meta.group || null,
		skillPath,
		body,
	};
}

/** Load all modes, sorted by (order, name). */
function loadModes(): Mode[] {
	if (!existsSync(modesDir)) return [];
	const modes: Mode[] = [];
	for (const file of readdirSync(modesDir)) {
		if (!file.toLowerCase().endsWith(".md")) continue;
		try {
			const mode = parseMode(file, readFileSync(join(modesDir, file), "utf8"));
			if (mode) modes.push(mode);
		} catch {
			// Skip unreadable files
		}
	}
	return modes.sort((a, b) => a.order - b.order || a.name.localeCompare(b.name));
}

export default function (pi: ExtensionAPI) {
	// Modes last seen on disk (sorted). Refreshed when the menu opens or a message is sent.
	let modes: Mode[] = [];
	// Ids of currently enabled modes. Seeded from `default: on` at session start.
	let enabled = new Set<string>();
	// Ids already injected into the conversation this session.
	let injected = new Set<string>();
	// Set while the menu is open; call to close it (false = cancel).
	let closeMenu: ((confirmed: boolean) => void) | null = null;

	function updateWidget(ctx: ExtensionContext) {
		if (!ctx.hasUI || ctx.mode !== "tui") return;
		const active = modes.filter((m) => enabled.has(m.id));

		if (active.length === 0) {
			ctx.ui.setWidget(WIDGET_ID, undefined);
			return;
		}

		const theme = ctx.ui.theme;
		const labels = active.map((m) => (injected.has(m.id) ? `${m.name} ✓` : m.name));
		ctx.ui.setWidget(WIDGET_ID, [
			theme.fg("accent", `◈ modes: ${labels.join(" · ")}`) + theme.fg("dim", "  (ctrl+q to change)"),
		]);
	}

	async function openMenu(ctx: ExtensionContext) {
		if (ctx.mode !== "tui") {
			ctx.ui.notify("Modes menu requires interactive mode", "warning");
			return;
		}

		modes = loadModes();
		// Drop toggles for modes that no longer exist on disk.
		enabled = new Set([...enabled].filter((id) => modes.some((m) => m.id === id)));

		if (modes.length === 0) {
			ctx.ui.notify(`No modes found in ${modesDir}`, "warning");
			updateWidget(ctx);
			return;
		}

		// Working copy; only committed to `enabled` on confirm.
		const working = new Set(enabled);

		const confirmed = await ctx.ui.custom<boolean>((tui, theme, _keybindings, rawDone) => {
			const items = modes;

			const done = (value: boolean) => {
				if (!closeMenu) return; // already closed
				closeMenu = null;
				rawDone(value);
			};
			closeMenu = done;

			let mode: "list" | "preview" = "list";
			let cursor = 0;
			let listScroll = 0;
			let previewScroll = 0;

			const itemRow = (m: Mode, idx: number, width: number): string => {
				const pointer = idx === cursor ? theme.fg("accent", "> ") : "  ";
				const checkbox = m.group
					? working.has(m.id)
						? theme.fg("success", "(•)")
						: theme.fg("dim", "( )")
					: working.has(m.id)
						? theme.fg("success", "[x]")
						: theme.fg("dim", "[ ]");
				const mark = injected.has(m.id) ? theme.fg("success", " ✓sent") : "";
				const dflt = m.defaultOn ? theme.fg("dim", " (default on)") : "";
				const desc = m.description ? theme.fg("dim", ` — ${m.description}`) : "";
				return truncateToWidth(`${pointer}${checkbox} ${theme.bold(m.name)}${mark}${dflt}${desc}`, width);
			};

			const buildPreviewRows = (m: Mode, width: number): string[] => {
				const rows: string[] = [];
				rows.push(truncateToWidth(theme.bold(m.name), width));
				const src = m.skillPath ? `skill: ${m.skillPath}` : m.id;
				rows.push(truncateToWidth(theme.fg("dim", `order ${m.order} · default ${m.defaultOn ? "on" : "off"} · ${src}`), width));
				rows.push(theme.fg("dim", "─".repeat(Math.min(width, 40))));
				for (const line of m.body.split("\n")) {
					for (const wrapped of wrapTextWithAnsi(line, width)) {
						rows.push(truncateToWidth(wrapped, width));
					}
				}
				return rows;
			};

			/**
			 * Slice `lines` to a scrollable viewport of at most `maxView` lines,
			 * reserving indicator slots when clipped.
			 */
			const viewport = (
				lines: string[],
				scroll: number,
				maxView: number,
				focusRow?: number,
			): { out: string[]; scroll: number } => {
				const clipped = lines.length > maxView;
				const view = clipped ? Math.max(1, maxView - 2) : maxView;

				let s = Math.min(Math.max(0, scroll), Math.max(0, lines.length - view));
				if (focusRow !== undefined) {
					if (focusRow < s) s = focusRow;
					else if (focusRow >= s + view) s = focusRow - view + 1;
				}

				const visible = lines.slice(s, s + view);
				if (!clipped) return { out: visible, scroll: s };

				const above = s;
				const below = lines.length - (s + view);
				return {
					out: [
						above > 0 ? theme.fg("dim", `  ↑ ${above} more`) : "",
						...visible,
						below > 0 ? theme.fg("dim", `  ↓ ${below} more`) : "",
					],
					scroll: s,
				};
			};

			return {
				render(width: number): string[] {
					const maxView = Math.max(5, tui.terminal.rows - 10);

					let content: string[];
					let title: string;
					let hints: string;
					if (mode === "list") {
						const rows = items.map((m, i) => itemRow(m, i, width));
						const v = viewport(rows, listScroll, maxView, cursor);
						content = v.out;
						listScroll = v.scroll;
						title = "Modes";
						hints = "↑↓ navigate • Space toggle • Tab preview • Enter apply • Esc cancel";
					} else {
						const m = items[cursor];
						const rows = buildPreviewRows(m, width);
						const v = viewport(rows, previewScroll, maxView);
						content = v.out;
						previewScroll = v.scroll;
						title = `Preview: ${m.name}`;
						hints = "↑↓ scroll • Tab/Esc back";
					}

					return [
						theme.fg("accent", "─".repeat(width)),
						truncateToWidth(` ${theme.fg("accent", theme.bold(title))}`, width),
						"",
						...content,
						"",
						truncateToWidth(theme.fg("dim", ` ${hints}`), width),
						theme.fg("accent", "─".repeat(width)),
					];
				},
				invalidate() {},
				handleInput(data: string) {
					if (data === "\x11") {
						// ctrl+q while open → hide
						done(false);
						return;
					}
					if (mode === "list") {
						if (matchesKey(data, Key.up)) {
							cursor = (cursor - 1 + items.length) % items.length;
							tui.requestRender();
						} else if (matchesKey(data, Key.down)) {
							cursor = (cursor + 1) % items.length;
							tui.requestRender();
						} else if (matchesKey(data, Key.space)) {
							const item = items[cursor];
							if (working.has(item.id)) {
								working.delete(item.id);
							} else {
								// Radio semantics: enabling clears others in the same group.
								if (item.group) {
									for (const other of items) {
										if (other.group === item.group) working.delete(other.id);
									}
								}
								working.add(item.id);
							}
							tui.requestRender();
						} else if (matchesKey(data, Key.tab)) {
							mode = "preview";
							previewScroll = 0;
							tui.requestRender();
						} else if (matchesKey(data, Key.enter)) {
							done(true);
						} else if (matchesKey(data, Key.escape)) {
							done(false);
						}
					} else {
						if (matchesKey(data, Key.up)) {
							previewScroll--;
							tui.requestRender();
						} else if (matchesKey(data, Key.down)) {
							previewScroll++;
							tui.requestRender();
						} else if (matchesKey(data, Key.tab) || matchesKey(data, Key.escape)) {
							mode = "list";
							tui.requestRender();
						}
					}
				},
			};
		});

		if (confirmed) {
			enabled = working;
		}
		updateWidget(ctx);
	}

	pi.on("session_start", (_event, ctx) => {
		if (!existsSync(modesDir)) mkdirSync(modesDir, { recursive: true });
		modes = loadModes();
		injected = new Set();
		// Seed from defaults — active immediately, no interaction required.
		// Radio groups: only the first default-on mode per group wins.
		enabled = new Set<string>();
		const seededGroups = new Set<string>();
		for (const m of modes) {
			if (!m.defaultOn) continue;
			if (m.group) {
				if (seededGroups.has(m.group)) continue;
				seededGroups.add(m.group);
			}
			enabled.add(m.id);
		}
		updateWidget(ctx);
	});

	pi.on("input", async (event, ctx) => {
		// Inject enabled modes that haven't been sent yet.
		const pending = [...enabled].filter((id) => !injected.has(id));
		if (pending.length === 0) return; // continue unchanged

		modes = loadModes();
		const active = modes.filter((m) => pending.includes(m.id));
		for (const m of active) injected.add(m.id);
		updateWidget(ctx);

		if (active.length === 0) return; // pending modes vanished from disk

		const bodies = active.map((m) => m.body);
		return {
			action: "transform",
			text: [...bodies, event.text].join("\n\n"),
		};
	});

	pi.registerShortcut("ctrl+q", {
		description: "Toggle modes",
		handler: async (ctx) => {
			if (closeMenu) {
				closeMenu(false); // menu open → hide it
				return;
			}
			await openMenu(ctx);
		},
	});

	pi.registerCommand("modes", {
		description: "Open the modes toggle menu",
		handler: async (_args, ctx) => {
			await openMenu(ctx);
		},
	});
}
