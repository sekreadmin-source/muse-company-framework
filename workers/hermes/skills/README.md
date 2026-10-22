# Hermes Worker Skills

Skills are the worker's playbooks: one folder per skill, one `SKILL.md`
per folder, installed into the worker's home (e.g. `~/.hermes/skills/`).
The COO's work packages invoke them by reference; the worker loads the
skill that matches the package's field.

This repo ships the **structural** worker skills — the ones about *how a
worker works for a COO* — plus domain skill *skeletons* showing the shape
a specialization takes. A deployment's real domain skills (its actual
research methods, platform recipes, and accumulated findings) are private
operating material and are written in the deployment, never published.

| Skill | Purpose |
| --- | --- |
| `work-package-execution` | How a package is executed: checkpoints, deliverable, done-criteria |
| `primary-source-verification` | Verify everything against official/primary sources |
| `browser-research` | Public-web research with a local browser, no account logins |
| `custody-and-signing-safety` | Key custody and the reject-always action classes |
| `deliverable-reporting` | Report shape: evidence, checkpoints, honest blockers |
| `session-discipline` | One package per session; keeper coordination; stall honesty |
| `security-research` | Domain skeleton: authorized security-program research |
| `platform-operations` | Domain skeleton: operating platform accounts/agents under packages |

Install: `install.sh` copies this folder into the deployment's workspace;
copy the skill folders you want into the worker home's skills directory,
or point the worker at them — follow your worker runtime's skill loading.
