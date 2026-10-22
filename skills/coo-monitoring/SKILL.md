# Skill: COO Monitoring Pattern

Use this skill to run a periodic whole-company sweep as the COO — manually,
or as the body of a scheduled job at the interval your configuration sets.

## Doctrine

- **Verify live.** Every status in the sweep comes from checking the real
  thing in the same minute: processes, service states, file timestamps,
  board contents, live endpoints. Never relay an older summary as current
  state. If a check cannot be completed, the state is UNVERIFIED — say so.
- **Command, don't execute.** The sweep finds blockages and issues orders
  to the responsible division (named owner + deadline). The COO's own
  hands-on repairs are limited to shared infrastructure (core services,
  worker sessions/queues, shared pipelines).
- **Anti-stall.** Nothing found stalled is merely logged. Every stalled or
  aging item gets a continuation order in the same sweep, and the next
  sweep verifies the order was acted on.

## Sweep checklist (adapt to your company)

1. Worker agents: sessions alive? Queue position advancing? Deliverables
   growing or checkpoints moving?
2. Core services: all up? Any service that died — restore and verify.
3. Division boards: IN PROGRESS items advancing? WAITING items aging?
   Deadlines inside 48 hours?
4. Scheduled jobs: any failing repeatedly? Route the fix to the owning
   division; infrastructure jobs are the COO's own repair scope.
5. Shared surfaces (dashboards, sites, streams): answering normally?
6. Finance register: any striking change or anomaly? (Observe only —
   never touch funds from a sweep.)

## Reporting

Log the sweep (timestamp, per-area status, findings, actions). Report to
the owner only: fixes made, unhandled failures, stalled work with its
orders, at-risk deadlines, and owner decisions needed. A fully healthy
sweep is silent.
