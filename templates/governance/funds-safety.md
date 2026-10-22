# Funds & Asset Safety (skeleton)

<!-- Principle-level safety frame for any deployment that touches money,
     wallets, or payment accounts. Fill in your own accounts and rules in
     your private deployment — account identifiers never belong in a repo. -->

## Separation

- **Operational funds** pay for work: tools, fees, working balances.
- **Personal funds** are the owner's. They receive withdrawals/payouts and
  are never used as working accounts for new activity.
- Legacy bindings that point at personal accounts get migrated to
  operational ones wherever the platform allows.

## Custody vs authority

- **Custody** (who physically holds keys/credentials) and **authority**
  (who decides their use) are different roles. Write down who holds each.
- Keys and secrets are never exposed: not in chat, not in files that leave
  the custody store, not in reports. Reports carry balances and addresses
  only where the owner has decided they belong.

## Absolute rules (examples — adopt or replace)

<!-- - Banned action classes are rejected always, regardless of who asks
       (e.g. blanket approvals, moving funds outside decided destinations).
     - Every use of a working account is authorized by a named order or a
       standing recipe approved in advance.
     - Spending decisions above <threshold> are the owner's. -->

## Oversight

- A finance register tracks every company account and its verified balance,
  refreshed on a schedule; the periodic company report carries a mandatory
  finance section sourced from it.
