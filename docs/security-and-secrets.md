# Security & Secrets

A company run by agents concentrates access: email, calendars, platforms,
sometimes funds. The framework's security posture is mostly *habits about
where things live*.

## The register pattern

- Keep **one credential register** (skeleton in
  `templates/governance/credential-bank-register.md`).
- The register holds: platform, account label, *where the secret is
  stored*, who may access it, status. **Never the value.**
- Legitimate value stores: the agent platform's secure vault, OAuth /
  registered connections, a password manager, or dedicated custody files
  with strict permissions held by the designated custody holder.

## What never goes in a repo (including private ones)

- Passwords, API keys, tokens, seed phrases, private keys.
- Government IDs, bank details, personal data files.
- Live workflow documents that reveal clients, prices, targets, or
  operational detail you would not publish.

The shipped `.gitignore` blocks the common paths, but it is a seatbelt,
not a review — read your diff before you push.

## Account hygiene

- One account per platform for the whole company; divisions register
  accounts themselves through the company's main identity and record them
  in the register the same day.
- Social and public accounts operated by agents should behave like
  ordinary users: human pacing, context first, no mechanical bursts. If a
  division runs a public account, it writes its own behavior guide from
  real observation of that platform before scaling activity.
- Sessions are precious: finish login-dependent work inside the session
  where the owner signed in; never park a task waiting on a sign-in.

## Funds

- Separate operational from personal money; give custody and authority to
  named roles; define banned action classes that are refused always.
  See `templates/governance/funds-safety.md`.
