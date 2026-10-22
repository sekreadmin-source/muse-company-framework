#!/usr/bin/env python3
"""Office event publisher — SKELETON (stdlib only).

Watches a workspace tree for changes and emits sanitized office events to
the relay (see ../events-contract.md and ../relay/README.md).

Design rules baked in:
  - Sanitize at the source: an event says "division X became active" —
    never file contents, never full paths, never message text.
  - Coalesce: at most one event per division per COALESCE_SECONDS.
  - The ingest secret comes from the environment, never from code.

Configuration (environment):
  OFFICE_WATCH_DIR      directory to watch (e.g. your workspace root)
  OFFICE_MAP_FILE       JSON: { "top-level-subdir": "division-id" }
  OFFICE_RELAY_URL      e.g. https://your-relay.example/ingest
  OFFICE_INGEST_SECRET  shared secret header value
  OFFICE_AGENT_MAP      optional JSON: { "subdir": "agent-id" };
                        default agent per division falls back to "lead"
"""
import json
import os
import sys
import time
import urllib.request

COALESCE_SECONDS = 5
POLL_SECONDS = 2


def snapshot(root):
    state = {}
    for dirpath, _dirs, files in os.walk(root):
        for name in files:
            path = os.path.join(dirpath, name)
            try:
                state[path] = os.path.getmtime(path)
            except OSError:
                pass
    return state


def main():
    watch_dir = os.environ.get("OFFICE_WATCH_DIR", ".")
    relay_url = os.environ.get("OFFICE_RELAY_URL", "")
    secret = os.environ.get("OFFICE_INGEST_SECRET", "")
    if not relay_url or not secret:
        print("OFFICE_RELAY_URL and OFFICE_INGEST_SECRET are required", file=sys.stderr)
        return 1
    with open(os.environ["OFFICE_MAP_FILE"], encoding="utf-8") as fh:
        dir_map = json.load(fh)
    agent_map = {}
    if os.environ.get("OFFICE_AGENT_MAP"):
        with open(os.environ["OFFICE_AGENT_MAP"], encoding="utf-8") as fh:
            agent_map = json.load(fh)

    previous = snapshot(watch_dir)
    last_sent = {}
    print(f"watching {watch_dir} → {relay_url}")
    while True:
        time.sleep(POLL_SECONDS)
        current = snapshot(watch_dir)
        changed = {p for p, m in current.items() if previous.get(p) != m}
        previous = current
        now = time.time()
        for path in changed:
            rel = os.path.relpath(path, watch_dir)
            top = rel.split(os.sep)[0]
            division = dir_map.get(top)
            if not division:
                continue
            if now - last_sent.get(division, 0) < COALESCE_SECONDS:
                continue
            last_sent[division] = now
            event = {
                "ts": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime(now)),
                "division": division,
                "agent": agent_map.get(top, "lead"),
                "kind": "work",
                "label": "activity",  # fixed string by design — no paths
            }
            req = urllib.request.Request(
                relay_url,
                data=json.dumps(event).encode(),
                headers={"Content-Type": "application/json",
                         "X-Office-Secret": secret},
                method="POST",
            )
            try:
                urllib.request.urlopen(req, timeout=5).read()
            except Exception as exc:  # relay down must never kill the watcher
                print(f"ingest failed: {exc}", file=sys.stderr)


if __name__ == "__main__":
    sys.exit(main())
