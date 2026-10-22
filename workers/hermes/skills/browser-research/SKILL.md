# Skill: Browser Research (worker)

Load this skill when a package needs live web pages read through a real
browser (JavaScript-heavy pages, dashboards, documentation portals).

## Boundaries

- **Research and public pages only.** The worker's local browser never
  carries the owner's account logins. Anything behind an owner login is
  the COO's or the owner's lane — checkpoint that and stop.
- Read-only by default. Clicks that change state (submitting, applying,
  posting, transacting) are outside a research package unless the package
  explicitly orders them and they are not owner-class actions.

## Practice

- Drive the browser through your runtime's local automation stack;
  prefer the page's own text/API responses over screenshots.
- Cite what you read: URL + the specific values, in the deliverable,
  per the primary-source-verification skill.
- **Resource discipline:** browsers are heavy. Close the browser when
  the package's browser work is done — a forgotten browser quietly eats
  the machine the whole company runs on.
- If a page is blocked (bot wall, geo-block, login wall), record the
  exact block and stop that thread; note alternative sources you did
  verify instead. Never route around a block with credentials or
  identity tricks.
