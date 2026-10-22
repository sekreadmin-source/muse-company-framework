# Muse Company Framework

A reusable **company operating framework** for [Muse](https://muse.ai) — the personal AI agent by Meta.

It turns a single Muse agent into the chief operating officer (COO) of a small,
multi-division company that *you* own and direct: you make the owner-class
decisions, the COO agent orchestrates, and division agents execute their own
fields of work from living task boards.

> **What this repo is:** the *frame* — structure, roles, document skeletons,
> governance bones, structural skills, and scaffolding tools.
>
> **What this repo is not:** anyone's real company data or finished workflows.
> Every workflow, recipe, price, and doctrine in a real deployment is private
> operational material. This framework ships empty on purpose: you fill it with
> your own.

## The shape

```
Owner (you)
  │  final decisions: money, identity, final submissions, major choices
  ▼
COO agent (your main Muse)
  │  monitors, commands, verifies — does not do desk work
  ▼
Divisions (one chat + one folder each)
  │  each division owns a field, a task board, and its own schedule
  ▼
Worker agents (optional, external)
     external executors/researchers driven by bounded work packages
```

Core principles (the frame — adapt the details freely):

1. **One source of truth per division:** a `TASKS.md` board. If it is not on the
   board, it is not being worked on.
2. **Verify live before reporting.** Status comes from checking the real thing
   (processes, files, logs) in the same minute — never from an old summary.
3. **The COO commands; divisions execute.** The orchestrator never absorbs desk
   work, so it stays available for the owner's direct orders.
4. **Decisions are devolved by class.** Routine decisions belong to the division
   that owns the work. Only owner-class decisions (funds, identity, final
   submission, major choices) escalate.
5. **Credentials are company property, held in proper stores only** — never in
   chat, never in this repo, never in memory files. A register records *where*
   each credential lives, never its value.
6. **Living documents.** Workflow files are revisable by the COO at any time;
   the owner's instructions always override them.

## Quick start

```bash
git clone https://github.com/<your-account>/muse-company-framework
cd muse-company-framework
cp config/company.example.yaml config/company.yaml
# edit config/company.yaml — company name, owner, timezone, divisions
./install.sh /path/to/your/muse/home
```

`install.sh` copies the skeletons into a Muse home layout:

- `AGENTS.md`, `SOUL.md`, `IDENTITY.md`, `USER.md`, `MEMORY.md` templates → home root
- `workspace/divisi/<division>/` → one folder per division you declare, each with
  `WORKFLOW.md`, `WORKFLOW-AGENT.md`, and `TASKS.md` skeletons
- `workspace/custom-skills/` → the structural skills from `skills/`
- `workspace/your_files/` → governance skeletons and registers

Then open Muse and have a first conversation with your COO: fill in `USER.md`
and `company.yaml` together, name your divisions, and write the first task
boards. Everything else grows from use.

## Repository layout

| Path | Contents |
| --- | --- |
| `config/` | One example configuration file — every knob lives here |
| `templates/` | Home-file skeletons (`AGENTS.md`, `USER.md`, …) with fill-in guidance |
| `templates/division/` | Per-division skeletons: workflow, agent workflow, task board |
| `templates/governance/` | Governance frame: decision classes, credential register, funds safety, registers, weekly report |
| `templates/queue/` | Work-package queue skeleton for external worker agents |
| `skills/` | Structural Muse skills (scaffolding, task boards, monitoring pattern, work packages) |
| `workers/hermes/` | Built-in worker integration: Hermes Agent as the reference additional agent — persona, config, queue keeper, service templates |
| `visualization/` | Built-in 3D virtual office: three.js viewer, event contract, publisher skeleton, relay contract |
| `tools/` | `scaffold-division.sh`, `check-structure.sh` |
| `examples/` | One fully fictional example company showing the filled shape |
| `docs/` | Architecture, customization guide, security & secrets |

## Built-in additional agent: Hermes

The worker slot ships with a reference implementation:
[Hermes Agent](https://github.com/NousResearch/hermes-agent) (Nous
Research, open source), integrated in `workers/hermes/` — persona and
config skeletons, a queue-keeper pattern that keeps worker sessions alive
and matched to the COO's work packages, custody patterns, and service
templates. Enabling it is optional; the slot contract (queue + packages +
COO verification) works with any worker you plug in.

## Make it yours

Nothing here is tied to any particular company, industry, or number of
divisions. Rename the roles, declare two divisions or nine, drop the worker
agent layer, or replace the funds-safety skeleton with your own — see
[`docs/customization.md`](docs/customization.md).

## Security

Never commit real data: no credentials, keys, wallet addresses, personal data,
client data, or live workflow documents. The included `.gitignore` guards the
usual paths, and [`docs/security-and-secrets.md`](docs/security-and-secrets.md)
explains the register pattern — record *where* a secret lives, never the secret.

## License

MIT — see [`LICENSE`](LICENSE).
