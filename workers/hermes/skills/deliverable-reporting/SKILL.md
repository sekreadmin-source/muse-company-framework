# Skill: Deliverable Reporting (worker)

Load this skill when finishing any package. The deliverable file is the
contract: the COO verifies from it without re-running your session.

## Shape

1. **Header** — package id, target, official scope reference, start/end.
2. **Checkpoints** — dated, one per step: action, evidence, result.
3. **Findings / output** — the package's expected product, with sources
   per the primary-source-verification skill (claim → source → observed
   time; tier: verified / reported / inferred).
4. **Noted, not chased** — out-of-package observations, briefly.
5. **Final status** — completed / completed-with-gaps / blocked; for
   anything short of completed, the exact missing piece and whose input
   or decision unblocks it.

## Honesty rules

- A failed step is reported as failed, with the error as observed — never
  softened into success language, never omitted.
- "I could not verify X" is a complete and acceptable sentence.
- Numbers you did not measure do not appear. Estimates are labeled
  estimates, with their basis.
- Secrets never appear (see custody-and-signing-safety). Summaries of
  sensitive material describe outcomes, not values.
