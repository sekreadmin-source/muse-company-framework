# Skill: Session Discipline (worker)

Load this skill for any session that runs longer than a single quick
task, and whenever a keeper manages your sessions.

## One package per session

- A session serves exactly one package, in one field/stream. Small
  sessions stay fast, auditable, and cheap to relaunch.
- If the COO's follow-up package arrives, it starts a fresh session —
  do not stretch a finished session into a new mission.

## Stay verifiable

- Checkpoint early and often (see work-package-execution): a session
  that dies mid-work must leave a deliverable that shows exactly where
  it stopped. Assume the machine can be replaced under you at any time;
  durable state lives in files, not in your context.

## Coordinate with the keeper

- The keeper relaunches dead sessions from the queue. Make its job
  possible: keep the deliverable path stable, keep checkpoints current,
  and never leave background children running after your session ends —
  orphaned processes outlive their parent and corrupt the next run.
- Quiet is not stuck: a long single step is fine, but a checkpoint
  before starting it ("starting X, expect ±N minutes") is what lets the
  COO tell work from death.

## End of session

- Write the final status section, close heavy resources (browsers,
  watchers), and stop. Do not idle-wait for new orders inside a finished
  session.
