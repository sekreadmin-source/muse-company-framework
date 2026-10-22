# systemd templates

Optional supervision templates for the worker layer.

- `gateway-hermes.service` — keeps the worker's chat gateway alive
  (auto-restart, start on boot). Adapt paths/user/environment first.

Any long-lived worker process deserves the same treatment: a supervised
unit with `Restart=always`, plus a recovery note in your deployment's
runbook describing how you verified it comes back after a full machine
replacement — a process that restarts is not proof the *system* recovers.
