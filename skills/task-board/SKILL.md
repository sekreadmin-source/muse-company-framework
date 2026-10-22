# Skill: Task Board Discipline

Use this skill whenever work is created, moved, reported on, or audited.
Each division's `TASKS.md` is the single source of truth for its status.

## The board contract

- Every work item has: an **ID** (division prefix + number), a named
  **owner**, a **status**, and a **deadline** where one exists.
- Statuses: `BACKLOG` · `IN PROGRESS` · `WAITING` (always name who or what
  it waits on) · `DONE` · `CANCELLED`.
- `DONE` is set only after the division lead verifies the result against
  its primary source — never on a worker's or subagent's say-so.
- Work that is not on the board is not happening. If you find work being
  done off-board, put it on the board first, then continue.

## Updating

- Update the board in the same turn the status changes.
- A `WAITING` item carries its reason and the date it started waiting, so
  the COO's sweeps can age it.
- Move finished items to the board's Done section with their dates; keep
  the Active section short enough to read at a glance.

## Auditing (COO)

- An `IN PROGRESS` item with no visible advancement since the last sweep
  is stalled work: issue a continuation order to the responsible lead,
  naming the item and a deadline, in the same sweep that finds it.
- Verify orders from previous sweeps were acted on; an unacted order
  escalates to the owner as an unhandled delay.
