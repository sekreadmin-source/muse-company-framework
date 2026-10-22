# Built-in 3D Office Visualization

A live 3D "virtual office" for the company: one room per division, one
figure per agent, and the company's real activity rendered as movement —
agents walk to their desks, work, and move between rooms as their work
advances.

```
workspace changes ─▶ publisher ─▶ relay (SSE) ─▶ viewer (three.js)
                     sanitize      broadcast      animate only
```

## The one design rule that matters

**Events are animation triggers. They are never rendered as text.**
There is no log panel, no event list, no chat feed on the office page —
activity shows as agents moving and rooms lighting up. A written log
defeats the purpose: the office is a *place you glance at*, not another
inbox. Any implementation of this component must keep that rule.

## Components

| Piece | File | Notes |
| --- | --- | --- |
| Viewer | `viewer/index.html` | Single self-contained page (three.js via CDN). Reads its layout from `office.json`. |
| Layout config | `office.json.example` | Rooms = your divisions; agents = your personas. No real names needed — labels come from config. |
| Event contract | `events-contract.md` | The schema every producer/consumer agrees on. |
| Publisher | `publisher/publisher.py` | Skeleton: watches a workspace tree, emits sanitized events to the relay. |
| Relay contract | `relay/README.md` | A tiny ingest→SSE broadcast contract; implement on any worker/edge platform. |

## How activity maps to animation

- An event names a **division** and an **agent** and a **kind**
  (`arrive`, `work`, `move`, `idle`, `leave`).
- The viewer moves that agent's figure in that division's room and
  raises the room's light while the division is active.
- Event payloads may carry a short human label for *your own* debugging
  at the relay — the viewer ignores text entirely.

## Demo mode

Open `viewer/index.html?demo=1` and the office animates with simulated
events — no relay needed — so you can see the shape before wiring yours.
For live mode, serve the page next to an `office.json` built from your
configuration and pass `?stream=<your relay SSE URL>`.

## Deployment

Any static host works for the viewer. The relay is any tiny service that
can hold an SSE connection and accept a POST with a shared secret (see
`relay/README.md`). Keep the ingest secret out of the repo: environment
only, on both the publisher and the relay.
