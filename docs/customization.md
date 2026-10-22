# Customization Guide

The framework is deliberately unfinished. This guide lists the joints where
a deployment makes it its own.

## Company identity

- `config/company.yaml` — name, owner addressing, timezone, language.
- `IDENTITY.md` — the COO agent's name and character. Renaming the COO is
  normal; the role matters, not the name.
- `USER.md` — how the owner wants to be addressed, in what language, with
  what level of detail. (E.g. short phone-first messages vs long reports.)

## Divisions

- Declare exactly the divisions your company needs — two is fine, nine is
  fine. Good division candidates are *fields with their own recurring work
  and their own sources of truth*, not steps of one pipeline.
- Rename the starter divisions (`services`, `research`) freely.
- Each division's lead persona name, researcher count, and task-ID prefix
  are yours to choose.
- Write the real workflows yourselves, in your deployment. Filled workflow
  documents are operating material — keep them out of public repos.

## Decision classes & escalation

- Re-draw the decision table in the governance skeleton to match your risk
  appetite: thresholds for spending, what counts as a "final submission",
  what must reach you immediately vs in the weekly report.

## Worker agents

- The worker layer is optional. Use it when you run a second agent runtime,
  a specialist service, or a human contractor. Define your own absolute
  rules in the queue file (funds rules are the classic example).

## Money

- The funds-safety skeleton is principle-level on purpose. Your accounts,
  wallets, thresholds, and destinations belong in your private deployment —
  never in a fork of this repo.

## Language & tone

- Templates ship in English. Translate any of them; structure survives
  translation. Many deployments run the chat language and the document
  language differently.
