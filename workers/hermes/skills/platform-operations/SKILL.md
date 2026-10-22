# Skill: Platform Operations (worker) — DOMAIN SKELETON

A specialization skeleton for operating accounts, agents, or presences
on third-party platforms under COO packages. A deployment fills in its
own platforms and recipes privately.

## Before first work on any platform

- Read the platform's official documentation for the exact operation
  (registration, sessions, claims, payouts) — the doc is the scope.
- Record the platform's binding facts in the deliverable: what identity
  an account binds to, what can and cannot be changed later (some
  bindings are permanent — discover that *before* acting, not after).
- Dated pre-execution check: re-verify the facts on the day of first
  execution; platform rules drift.

## Sessions & recipes

- Recurring operations become **standing recipes**: numbered steps, the
  expected evidence per step, and the stop conditions. The COO approves
  a recipe once; executions follow it and report deviations.
- Every session reports: what ran, evidence (ids, timestamps, balances
  where public), what was skipped and why. A step is never silently
  skipped — a skipped step with a reason is a valid outcome; a silent
  one is a defect.
- Behavior on shared platforms is human-paced and ordinary (see the
  deployment's social-behavior rules): no mechanical bursts, no mass
  actions.

## Money and identity edges

- Registrations use the company's operational identities/accounts per
  the governance rules; legacy bindings get migrated where the platform
  allows, and the migration (or its impossibility) is documented.
- Anything needing the owner's own login, identity verification, or
  signature stops at that step and is checkpointed for the owner — the
  worker never holds the owner's personal session.
