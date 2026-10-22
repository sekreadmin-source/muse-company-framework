# Skill: Company Scaffold

Use this skill when the owner wants to create a new division, add a worker
agent, or restructure the company layout.

## Creating a division

1. Read `config/company.yaml` (or the deployment's configuration) for the
   division's slug, name, mission, lead persona, and task-ID prefix.
2. Run `tools/scaffold-division.sh <slug> "<Division Name>" <PREFIX>` — it
   creates the division folder from `templates/division/` and substitutes
   the placeholders.
3. Create (or ask the owner to create) the division's dedicated chat, and
   record it in the agent registry.
4. Open the division's first session by writing its mission and first three
   backlog items onto its `TASKS.md` board with the lead persona.
5. Report to the owner: folder, chat, lead, first board items.

## Rules

- One division = one field. If the mission overlaps an existing division,
  surface the overlap to the owner before scaffolding.
- Never scaffold credentials, accounts, or registrations inside this skill —
  those follow the credential register process.
- The COO does not execute the new division's work; the division's own lead
  picks it up from the board.
