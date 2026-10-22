# Credential Bank Register (skeleton)

<!-- ONE register for every company account and credential. The register
     records names, owners, WHERE each secret lives, who may access it, and
     its status — NEVER the secret value itself.
     Legitimate homes for values: your agent platform's secure vault,
     OAuth/registered connections, dedicated key custody (e.g. a worker
     agent's key files with strict permissions), password manager.
     One account per platform, shared by the whole company. -->

| # | Platform / service | Account label | Secret stored in | Access | Status | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | <!-- e.g. Email provider --> | <!-- label --> | Secure vault | COO + owning division | Active | |
| 2 | | | | | | |

## Rules (adapt freely)

<!-- Bones that hold in most deployments:
- A registration made by any division is company property, recorded here the
  same day.
- Password policy: define yours (e.g. one master password for company logins,
  platform exceptions recorded here with the reason).
- Personal data for official forms lives in ONE owner-data store, routed only
  through the COO; identity documents and bank data are never stored by the
  company — those steps stay with the owner, on official platforms only.
-->
