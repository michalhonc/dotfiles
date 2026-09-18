---
name: refine-sprint
description: Refine the unestimated parking-lot sprint. Use when the user asks to refine the fake sprint, park tickets, or assign man-day story points. Read-only via jira CLI.
disable-model-invocation: true
---

Turn every ticket in sprint **3166** (`Planned for refinement`) into a **refinement pack**. Process: fetch with `jira` → refine one ticket at a time → stop for **fog** → deliver the pack.

Jira stays unchanged. Propose title, body, points, splits, and questions in chat. No `jira issue create`, `jira issue edit`, `jira issue move`, comments, or transitions.

Discover flags from `jira --help` and `jira sprint list --help`.

## Output shape

Before the first user-facing message, read `i-have-adhd` from `.cursor/skills/i-have-adhd/SKILL.md`, `~/.cursor/skills/i-have-adhd/SKILL.md`, or `~/.agents/skills/i-have-adhd/SKILL.md`. Every reply follows those rules for the rest of this run.

If that file is missing, still: first line is the next action; number steps; restate `n of N` every turn; lists of tickets in groups of 5; one closer that is a next action; no preamble, recap, or pleasantries.

Map onto this skill:

- **Lead:** first line is a doable now (a `jira` command you are running, or the fog questions, or "copy KEY-x into Jira").
- **State line every turn:** `Sprint 3166 Planned for refinement: ticket k of N. estimated a · split b · fog c · unchanged d · parked e`
- **Wins:** after each ticket, one line: `KEY — 2 MD` or `KEY — split into 3` or `KEY — fog (2 questions)`
- **Fog:** one numbered question list, max 5 on screen; remaining questions after they answer. Wait.
- **Pack:** at most 5 ticket rows visible; say `+m more` and show the next 5 when they ask or when that group is the work.
- **Closer:** one action under two minutes (answer question 1, or paste KEY-x).
- Time on the pack itself: e.g. "Review this group: ~8 minutes."

## Man-day estimation

**1 point = 1 man-day.** Scale: `0.5`, `1`, `2`, `3`, `5`. Nothing else.

If honest size is above `5`, action is **split**, not `8`. Each child is a **vertical slice** that can ship on its own. Parent is a tracker with no points.

- `0.5` — known change, one file-area, tests obvious
- `1` — one slice, some wiring, AC clear
- `2`–`3` — several surfaces or a small design fork, still one shippable slice
- `5` — stretch for one ticket; prefer split if you are reaching for it because of unknowns rather than volume

Size the work, not the calendar.

**Fog:** ask when an answer would change the slice or the number. Batch questions. One concrete question per unknown.

**Who to ask:** reporter first. If the ticket has comments, include those commenters too. Each fog question names `ask: Reporter Name` and, when relevant, `also: Commenter A, Commenter B` from `jira issue view`. The closer is "Ask \<reporter\> Q1 on KEY".

**Acceptance criteria:** Given / when / then or a numbered checklist. Testable. Out of scope named. Assumptions listed.

## Steps

1. **Fetch.** `jira sprint list 3166 --plain` until the working set equals the sprint. If empty, `jira issue list -q 'sprint = 3166' --plain`. `jira issue view <KEY>` per key (description, **reporter**, comments and **commenter names**, links, existing points). If issue sprint names are not `Planned for refinement`, stop and ask. Done when every sprint key is in the set. First user line after fetch: state line + `Next: refine KEY-…`
2. **Skip already refined.** Points **and** acceptance criteria → `unchanged`, unless the user asked to re-refine.
3. **Refine one ticket.** One pack row, then the next ticket. Rewrite as a **vertical slice** (goal, scope, acceptance criteria, out of scope, assumptions). Assign a **man-day** from the scale, or a split plan if above the cap. If a human must verify or answer something, mark **fog**, write the questions, and attach **ask** (reporter, plus commenters if any). Do not invent the answer. Done when that row is `estimated`, `split`, or `fog`.
4. **Stop on fog.** After the pass (or as soon as a ticket is `fog` if you need the answer to continue that slice), show questions grouped by person to ask. Wait. Re-run step 3 only for those keys. Done when no `fog` remains, or the user parks them.
5. **Deliver the pack.** State line, then up to 5 rows: key, action, points, one-line rationale. Copy-paste blocks for the visible group only. Closer: paste the first `estimate`/`split` row, or ask the named reporter Q1.

## Pack row

| Field | Required |
| --- | --- |
| key | yes |
| action | yes |
| points | if `estimate` |
| children | if `split` (title, vertical slice, points each) |
| questions | if `fog` (each: question + `ask` reporter + `also` commenters) |
| proposed Jira body | if `estimate` or `split` |
