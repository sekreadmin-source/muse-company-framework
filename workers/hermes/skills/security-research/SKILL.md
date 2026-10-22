# Skill: Security Research (worker) — DOMAIN SKELETON

A specialization skeleton for authorized security research (e.g. public
bug-bounty programs). It shows the shape a domain skill takes; a
deployment writes its own targets, rules, and findings history privately.

## Scope first, always

1. Read the program's **official scope and rules** before touching
   anything: in-scope assets, out-of-scope assets, testing rules,
   safe-harbor terms, disclosure policy, reward structure.
2. Work only inside the written scope. Ambiguity resolves toward *less*
   testing, and the question goes to the COO — never resolved by testing
   first.
3. Respect the program's rate limits, prohibited techniques, and
   test-account rules exactly as published.

## Research loop (structure to specialize)

- Map the in-scope surface from the official scope document.
- Form hypotheses; test the least invasive proof that settles each one.
- Keep evidence per finding: reproduction steps, requests/responses,
  impact reasoning tied to the program's own severity rubric.

## Findings & submission

- A finding is a file: summary, severity per the program's rubric,
  reproduction, evidence, impact, suggested remediation.
- The worker **never submits**. Submission happens from the owner's own
  account and session — an owner-class act. The worker prepares; the
  COO verifies the draft against the scope; the owner sends.
- Unverified hypotheses are labeled as such and never dressed as
  findings.
