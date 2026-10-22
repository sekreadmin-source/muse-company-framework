# Built-in Worker: Hermes Agent

This framework ships with a first-class integration for
[Hermes Agent](https://github.com/NousResearch/hermes-agent) (Nous Research,
open source) as the reference **worker agent** — an additional agent that
executes work packages issued by the COO.

Hermes is optional. A deployment can run COO-only, use Hermes, or plug a
different worker into the same slot. The slot is the contract; Hermes is
the reference implementation.

## The slot contract

```
COO ──work package──▶ queue file ──keeper──▶ Hermes session
Hermes ──deliverable file──▶ COO verification ──▶ owner report
```

- The COO issues **work packages** (see `skills/work-package/SKILL.md`):
  target, official scope reference, expected deliverable, absolute rules.
- Packages wait in a **queue file** (skeleton:
  `templates/queue/worker-queue.md`). A **keeper** watches the queue and
  keeps worker sessions alive: one session per work stream, relaunched
  automatically after interruptions (machine restarts kill sessions;
  services must not be assumed immortal).
- Hermes works with **full authority over its own methods and tools**
  inside a package. The COO verifies every deliverable against primary
  sources before anything reaches the owner.
- Substantive decisions never ride inside a package: funds, identity,
  final submissions, and major choices stay with the owner.

## What lives where (in your deployment)

| Piece | Place | This repo ships |
| --- | --- | --- |
| Hermes installation | your machine (upstream installer) | pointers, not a copy |
| Worker persona | Hermes home (e.g. `~/.hermes/SOUL.md`) | `persona-SOUL.md` skeleton |
| Worker configuration | Hermes home | `hermes-config.example.yaml` |
| Credentials | Hermes custody files, strict permissions | never — patterns only |
| Model routing | any OpenAI-compatible endpoint/router | placeholder config |
| Gateway (chat control) | a supervised service | `systemd/gateway-hermes.service` template |
| Queue keeper | a scheduled job in Muse | `keeper-prompt.md` skeleton |
| Session launcher pattern | local scripts | `session-keeper.sh` skeleton |

## Field roles

Give Hermes **named roles per work stream** (for example "research lead"
for one division, "operator" for another) and keep the streams separate:
a session works one package, in one field, at a time. Cross-stream
coordination is the COO's job, never the worker's.

## Custody pattern (if the worker touches funds or keys)

The worker can be your **custody holder** while the COO holds
**orchestration authority** and the owner holds **decision authority**:

- Keys live only in the worker's custody store, strict permissions,
  never copied into chat, repos, or the COO's files.
- Every use of a working account is authorized by a COO work package or a
  standing recipe the COO approved.
- Banned action classes (define yours) are rejected always, by the
  worker, regardless of who asks.

See `templates/governance/funds-safety.md` for the principle-level frame.

## Enabling Hermes in an installed deployment

1. Install Hermes Agent from its upstream project.
2. Copy `persona-SOUL.md` into the Hermes home and fill in your roles.
3. Copy `hermes-config.example.yaml`, point it at your model endpoint,
   and store credentials through Hermes' own mechanisms — never in the
   YAML in a repo.
4. Create the queue file from `templates/queue/worker-queue.md` and tell
   the COO (in `AGENTS.md`) the queue path, the keeper cadence, and the
   streams Hermes serves.
5. If you want chat control, adapt the systemd gateway template; a
   keeper scheduled job in Muse (skeleton: `keeper-prompt.md`) keeps
   sessions matched to the queue.
