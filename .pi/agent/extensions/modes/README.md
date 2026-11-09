# Modes

MD skills loaded upfront, prior to the first prompt.

- Each mode is a markdown file in `modes/` with frontmatter:
  - `name`, `description` — display
  - `default: on|off` — active from session start without any interaction
  - `order` — injection/list order (lower first)
  - `skill: <path>` — optional; load the body from an external SKILL.md
    (`~` expanded, frontmatter stripped). Any body in the mode file itself
    is appended after the skill body.
  - `group: <name>` — optional; radio semantics: at most one mode per group
    can be on (shown as `(•)` instead of `[x]`).
- Default-on modes apply automatically — type right away and they are
  prepended to your first message.
- Inside `~/git/michalhonc` (and subfolders) all modes start unchecked,
  ignoring `default: on` (see `NO_DEFAULTS_DIRS` in `index.ts`).
- Press **ctrl+q** or run **/modes** to open the toggle menu
  (space: toggle, tab: preview, enter: apply, esc/ctrl+q: hide).
- Each enabled mode is injected once per session, on the next message after
  it was enabled (`✓` marks already-sent modes). Disabling an injected mode
  can't retract it — tell the model to stop instead.

## Bundled modes

- `adhd` — default **on**, from `~/.agents/skills/adhd/SKILL.md`
- `caveman` — default **off**, from `~/.agents/skills/caveman/SKILL.md`
- `DNA` — default **on**, group `account`: m-honc GitHub, `JIRA_API_TOKEN`, `FIGMA_TOKEN`
- `DIG` — default **off**, group `account`: michalhonc GitHub, `JIRA_DIGITOO_API_TOKEN` + `JIRA_DIGITOO_API_EMAIL`, `FIGMA_DIGITOO_TOKEN`
