# Office Relay — contract

The relay is a tiny broadcast hub between event producers (the publisher)
and the viewer. Implement it on anything that can hold an SSE connection:
an edge worker, a small Node/Python service, a serverless function with a
durable object — the contract is the product, not the runtime.

## Endpoints

### `POST /ingest`

- Header: `X-Office-Secret: <shared secret>` — reject anything else.
- Body: one event (see `../events-contract.md`) *without* `seq`.
- The relay assigns the next `seq`, appends the event to a ring buffer
  (last ±200), and broadcasts it to all stream subscribers.
- Response: `202` with the assigned `seq`.

### `GET /stream`

- `Content-Type: text/event-stream`.
- On connect, replay the ring buffer (oldest → newest) so a fresh viewer
  immediately shows the current rhythm, then stream live events.
- Each event is one SSE message whose data is the event JSON.
- Send a heartbeat comment every ±20s so proxies keep the connection.

### `GET /events?after=<seq>`

- JSON array of buffered events with `seq > after`. For polling clients
  and debugging — remember the viewer's rule: labels are for debugging,
  never for display.

### `GET /health`

- `200` with buffer size and subscriber count.

## Rules

- One hub instance holds the buffer (a singleton): multiple stateless
  replicas each holding their own buffer will fork the office's reality.
  Use a single process, or a platform primitive that serializes access
  to one object.
- The ingest secret lives in the relay's environment and in each
  producer's environment — nowhere else, and never in this repo.
- CORS: allow your viewer's origin on `/stream` and `/events`.
- The relay stores nothing beyond the ring buffer. It is a nerve, not a
  database.
