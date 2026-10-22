# Hermes3D Studio — local 3D-office frontend

A third-party (iamlukethedev/Hermes3D) Next.js + React Three Fiber app that renders the agent as a navigable 3D office, driven by a gateway connection. **Frontend only** — it never installs or builds Hermes; the runtime must already be running.

## Locate it

On this machine the working copy is `~/workspace/hermes3d`. Find it with a file search for `hermes3d` rather than assuming a path — do not guess `/home/<user>/Hermes3D`.

## Check the port before telling the user to open a URL

"How do I look at Hermes3D?" usually means "start it" or "is it up?". Verify first:

```bash
ss -ltn | grep -E ':3000|:18789|:9120'
curl -s -o /dev/null -w '%{http_code}\n' -m 3 http://127.0.0.1:3000/
```

If nothing is listening, give the run steps below and offer to start `npm run dev` in the background. Never tell the user to open `localhost:3000` unchecked — a dead port wastes their time and reads as a broken recommendation.

## Run it

```bash
cd ~/workspace/hermes3d
npm install     # first time only
npm run dev     # Studio at http://localhost:3000
```

Then open `http://localhost:3000` and set the gateway URL + token in Studio, which persists the chosen backend mode (`Hermes`, `Demo`, `Local`, `Hermes3D`, `Custom`).

Backends:

- **Demo (no real agent):** `npm run demo-gateway` in a second terminal, then connect Studio to `ws://localhost:18789`.
- **The local Hermes gateway:** the agent's own JSON-RPC endpoint, e.g. `ws://localhost:9120/api/ws?token=…` as recorded in the app's `server.log`. Read the token from the log file — log lines surfaced to you are redacted, and a token must never be typed or echoed into chat.
- **Custom / HTTP runtime:** point the upstream URL at the runtime boundary (`http://127.0.0.1:7770`, or Studio's own `/api/runtime/custom`).
- **Cross-machine setup** (Hermes + Tailscale + Hermes3D): follow the app's `TUTORIAL.md`.

Other scripts worth knowing: `npm run doctor` (hermes3doctor diagnostics), `npm run hermes-adapter` (adapts the Hermes HTTP API, default `http://localhost:8642`, to the gateway protocol).
