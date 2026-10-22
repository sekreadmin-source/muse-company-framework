# Architecture

The framework is a *management operating system* layered on top of a single
Muse agent. It has four layers:

## 1. Identity & memory layer

The home files — `AGENTS.md`, `SOUL.md`, `IDENTITY.md`, `USER.md`,
`MEMORY.md` — give the agent a stable self, a model of its owner, an
operating manual, and a curated long-term memory. Everything else in the
company reads from these.

## 2. Governance layer

The governance skeletons define decision rights: which decisions belong to
the owner, which to the COO, which to a division. They also hold the
registers (agents, credentials, finances) — the company's maps of who
exists, where access lives, and where the money is. Registers record
*pointers and statuses*, never secrets or live operational detail.

## 3. Division layer

Each division is a folder, a chat, a lead persona, and three living
documents:

- `WORKFLOW.md` — the division's process.
- `WORKFLOW-AGENT.md` — the conduct of the agents inside it.
- `TASKS.md` — the board: the single source of truth for its work.

Divisions are field-locked: each works only in its own field, and
cross-division traffic routes through the COO. A division owns its
schedule, its tools, and the recovery of its own work.

## 4. Execution layer

Work happens through three channels:

- **Division sessions** — the lead works its board, using subagent teams
  for scouting and drafting; the lead verifies everything against primary
  sources.
- **Scheduled jobs** — recurring rhythms (briefs, collectors, check-ins,
  reports) owned by the division they serve; the COO's monitoring job is
  the one company-wide rhythm.
- **Worker packages** — optional external worker agents executing bounded
  packages from a queue, verified by the COO on delivery. The framework's
  built-in reference worker is Hermes Agent (`workers/hermes/`): a keeper
  keeps its sessions matched to the queue, and it may also hold custody of
  working credentials/keys while the COO holds orchestration authority.

## The COO loop

The COO's whole job is a loop: **monitor → command → verify**. Sweeps run
on an interval; every sweep checks live state, issues orders for anything
stalled, and verifies the previous sweep's orders were acted on. The COO's
hands stay off desk work so the owner always has a free hand to command.
