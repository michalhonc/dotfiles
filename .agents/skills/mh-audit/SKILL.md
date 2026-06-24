---
name: mh-audit
description: Runs a lightweight recurring frontend maintenance audit, surfaces small safe improvements, and writes the results to `AUDIT_REPORT.md`. Use when the user wants a periodic audit, minor issues, nitpicks, DX cleanup, dependency hygiene, low-risk performance follow-up, or a root-level audit report.
---

# Audit

Run repo-native checks, apply only tiny deterministic fixes, and overwrite `AUDIT_REPORT.md`. This skill is designed for recurring, low-risk maintenance — not large refactors or feature work.

## Quick start

1. Determine the active worktree from `cwd`. Default to `fe/main/` only when invoked from the monorepo root (`dig/`).
2. Pre-flight: ensure deps and codegen are current.
   - `yarn install --frozen-lockfile`
   - `yarn codegen`
3. Run checks:
   - `yarn lint` (flat ESLint config via `eslint.config.mjs` — never create `.eslintrc.*` files)
   - `yarn tsc`
   - `npx knip` (respects `knip.json` — do not override its exclusions for generated code, cypress, etc.)
   - `yarn i18n:validate`
   - `yarn i18n:unused`
   - `yarn test-storybook` (Vitest-based Storybook tests)
4. Optionally run `yarn prettier --check "**/*.{ts,tsx}"` to detect formatting drift (do not auto-fix — see Apply/Report rules).
5. Use `yarn outdated` or `npx npm-check-updates --format group` for dependency drift when useful.
6. Run `yarn build:analyze` only if a cheap signal suggests a perf issue.
7. Write the report to `AUDIT_REPORT.md` at the worktree root.

## Workflows

### Standard audit

1. **Establish scope**
   - Confirm the worktree root and any user focus area.
   - Classify findings as correctness, DX/cleanup, safe perf, or dependency hygiene.
2. **Pre-flight**
   - `yarn install --frozen-lockfile` — ensures `node_modules` match the lockfile.
   - `yarn codegen` — regenerates API types so `tsc` and `lint` don't produce false positives from stale types.
3. **Run repo-native checks**
   - Prefer scripts and config already present in `package.json`, ESLint (`eslint.config.mjs`), TypeScript, Knip (`knip.json`), and project docs.
   - Include `yarn test-storybook` for Vitest-based component tests.
4. **Triage findings** (see Apply/Report rules below)
5. **Verify** — re-run only the relevant checks for touched areas.
6. **Report** — overwrite `AUDIT_REPORT.md`.

### Apply/Report rules

**Apply** (safe, deterministic, small diff):
- Unused imports and dead code proven by tooling.
- Trivial lint/type fixes (e.g., missing return types caught by ESLint).
- Narrow DX cleanups and obviously redundant work.

**Report only** (needs human review or risks regression):
- Risky deletions, refactors, API changes, large typing rewrites.
- Bundle work without measurement and major dependency updates.
- Prettier formatting — never auto-fix; it touches too many files and pollutes diffs.
- Unused i18n keys — requires product confirmation before removal.
- Knip-detected unused files — report unless the file is clearly test/dev scaffolding with no production import path.

### Dependency sub-workflow

- Check `yarn outdated` or `npx npm-check-updates --format group`.
- Review `patches/` directory for `patch-package` patches that reference outdated versions.
- Verify `.nvmrc` node version aligns with CI and team expectations.
- Note the `postinstall` hook runs `patch-package` — do not skip it or remove patches without verifying the upstream fix landed.
- Separate findings into: safe updates, risky updates, deprecated/suspect packages.

### Writing the report

Use this structure every time:

```md
# Audit Report

## Scope
- Date/time
- Worktree root
- Area audited
- Audit intent

## Commands Run
- `...`

## Fixes Applied
- `path/to/file` — what changed, why it was safe, which check justified it

## Findings Not Applied
- category/severity
- file or package
- evidence
- recommended follow-up
- why it was deferred

## Dependency Notes
- safe updates
- risky updates
- deprecated or suspect packages
- patch-package status

## Performance Notes
- measured or suspected issue
- evidence
- follow-up suggestion

## Summary
- total fixes applied
- total deferred items
- highest-value next step
```

## Advanced features

- Prefer report-only when a change is ambiguous, cross-cutting, or user-visible.
- Never remove framework-discovered files, generated code, or exports unless tooling proves they are unused.
- Explicitly say `None` for empty sections.
- Keep observed issues separate from applied changes.
- Keep the audit lightweight and evidence-backed.
