# Office Event Contract

One contract between producers (publisher, agent tooling) and consumers
(the relay, the viewer). Keep it this small — a bigger schema is a worse
office.

## Event shape (JSON)

```json
{
  "seq": 123,
  "ts": "2026-01-01T09:15:00Z",
  "division": "services",
  "agent": "lead-a",
  "kind": "work",
  "label": "short human note — debugging only, never rendered"
}
```

| Field | Rule |
| --- | --- |
| `seq` | Monotonically increasing per relay; consumers dedupe on it and may replay from a ring buffer after reconnect. |
| `ts` | ISO-8601 UTC. |
| `division` | Must match a room `id` in `office.json`. Unknown divisions are ignored by the viewer. |
| `agent` | Must match an agent `id` in `office.json`. Unknown agents are ignored. |
| `kind` | One of `arrive` · `work` · `move` · `idle` · `leave`. |
| `label` | Optional, ≤ 240 chars, sanitized by the producer (no file paths, no secrets, no personal data). The viewer MUST NOT display it (see the design rule in `README.md`). |

## Kind → animation

| Kind | Viewer behavior |
| --- | --- |
| `arrive` | Agent figure fades/walks in at the room door; room light up. |
| `work` | Agent sits at a desk in the room; room activity light stays up for a decay window. |
| `move` | Agent walks to another position (optionally another room if `division` changes between events). |
| `idle` | Agent stands; activity decays. |
| `leave` | Agent walks out; figure dims. |

## Producer rules

- **Sanitize at the source.** An event is derived from "something changed
  in the workspace" — never copy raw file contents, paths, or message
  text into an event.
- **Throttle.** Coalesce bursts (e.g. one event per division per few
  seconds); the office shows rhythm, not keystrokes.
- **Authenticate.** Ingest requires the shared secret header (see
  `relay/README.md`). The secret lives in environment variables only.
