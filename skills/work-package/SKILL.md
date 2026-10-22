# Skill: Work Packages for Worker Agents

Use this skill when delegating work to an external worker agent (a separate
agent runtime, a specialist tool, or a human contractor coordinated in
writing).

## Package shape

A work package is a coordination tool, not a cage. It states:

1. **Target** — the one thing this package is about.
2. **Official scope reference** — the authoritative source that bounds the
   work (a program's rules page, a spec, a ticket).
3. **Expected deliverable** — a named file or artifact, and its location.
4. **Absolute rules** — the deployment's non-negotiables (e.g. funds rules,
   no-final-submission). These bind always.

Methods, tools, and step order inside the package are the worker's own
authority. Out-of-package findings are noted, not chased, until a follow-up
package orders them.

## The loop

```
COO issues package → worker reports → COO verifies against primary
sources → follow-up package for gaps → … → done-criteria met
```

- One package per work session keeps sessions small and fast.
- Verification is against primary sources (the official scope, the live
  system, the chain, the document) — never against the worker's summary.
- Substantive decisions (funds, identity/final submission, major choices)
  never ride inside a package; they stay with the owner.

## Queue discipline

Packages live in the worker queue file in execution order, with their
deliverable paths, so any sweep can tell at a glance what is running, what
is next, and what has been verified done.
