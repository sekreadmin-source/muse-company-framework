#!/usr/bin/env bash
# session-keeper.sh — SKELETON launcher pattern for worker sessions.
#
# Adapt the launch line to your worker runtime. The pattern that matters:
#   one session per stream · started from the queue's head package ·
#   logs appended per stream · safe to run repeatedly (idempotent: an
#   alive session is left alone).
#
# Usage: session-keeper.sh <stream-name> <package-file>
set -euo pipefail

STREAM="${1:?usage: session-keeper.sh <stream-name> <package-file>}"
PACKAGE_FILE="${2:?missing package file}"

WORKER_HOME="${WORKER_HOME:-$HOME/.hermes}"
LOG_DIR="${LOG_DIR:-$HOME/workspace/worker-logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/${STREAM}.log"
PID_FILE="$LOG_DIR/${STREAM}.pid"

# Already alive? Leave it alone.
if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  echo "stream $STREAM already running (pid $(cat "$PID_FILE"))"
  exit 0
fi

# ── Adapt this launch line to your worker runtime ──────────────────────
# Example shape for a CLI-driven agent that takes a query file:
#   nohup your-worker-cli chat --query-file "$PACKAGE_FILE" \
#     >> "$LOG_FILE" 2>&1 &
echo "TODO: replace with your worker launch command" >&2
exit 1
# ────────────────────────────────────────────────────────────────────────

# echo $! > "$PID_FILE"
# echo "stream $STREAM launched (pid $!) — log: $LOG_FILE"
