---
name: oxbf-proxy
description: Operate the oxbf proxy Telegram bot (cards, TOTP, mail).
version: 0.1.0
author: Nefo, Hermes Agent
license: MIT
platforms: [linux]
metadata:
  hermes:
    tags: [oxbf, telegram, bot, tooling]
    related_skills: [immunefi]
---

# oxbf proxy Skill

Operates the **oxbf proxy** Telegram bot — a self-hosted utility bot that
generates test card numbers, random identities, TOTP codes, disposable mail,
and manages a Webshare/FreeProxy pool. Installed at
`/home/hatch/workspace/oxbf-proxy` with its own Python 3.12 virtualenv.

This skill does NOT create accounts, register accounts on third-party sites, or
bypass any site's defenses. It covers install, configure, start/stop, health,
and the offline test suite for a bot the operator runs under their own
Telegram account.

## When to Use

- Owner asks to start/stop/restart the oxbf proxy bot, or check whether it is up.
- Owner asks to configure bot token, admin IDs, captcha provider, or tempmail domain.
- Owner asks to reinstall dependencies, re-run the smoke test, or inspect bot health.
- Owner asks what the bot does, which commands it exposes, or where its data lives.

**Don't use for:** the 5-division mission, bug bounty recon, wallet operations,
or anything unrelated to this specific app.

## Prerequisites

- App dir: `/home/hatch/workspace/oxbf-proxy` (already provisioned)
- Python: `/usr/bin/python3.12` → venv at `venv/` (`venv/bin/python`)
- Secrets: `/home/hatch/workspace/oxbf-proxy/.env` (mode 600, git-ignored)
- Required env keys (read by `config.py`):
  - `OXBF_BOT_TOKEN` — token from @BotFather (**required**)
  - `OXBF_ADMIN_IDS` — comma-separated Telegram user_id of the owner (**required**)
  - `OXBF_2CAPTCHA_API_KEY` — 2captcha key, required for Webshare auto-register
  - `OXBF_CAPTCHA_PROVIDER` — `2captcha` (default) or `azcaptcha`
  - `OXBF_AZCAPTCHA_API_KEY` — only if provider is `azcaptcha`
  - `OXBF_TEMPMAIL_DOMAIN` — own tempmail domain
  - `OXBF_FIXED_PASSWORD` — password used for auto-register
- `.env.example` holds the template. Real values are never echoed, logged, or
  passed as command-line arguments.

## How to Run

Canonical start (systemd, survives logout):

```
terminal(command="systemctl start oxbf-proxy", timeout=60)
terminal(command="systemctl status oxbf-proxy --no-pager", timeout=60)
```

Standalone (no systemd), for foreground debugging:

```
terminal(command="cd /home/hatch/workspace/oxbf-proxy && ./venv/bin/python -u bot.py", timeout=60)
```

## Quick Reference

| Task | Command |
|---|---|
| Start | `systemctl start oxbf-proxy` |
| Stop | `systemctl stop oxbf-proxy` |
| Restart | `systemctl restart oxbf-proxy` |
| Status | `systemctl status oxbf-proxy --no-pager` |
| Logs | `tail -n 50 /home/hatch/workspace/oxbf-proxy/data/oxbf.log` |
| Standalone start | `/home/hatch/workspace/oxbf-proxy/start-oxbf.sh` |
| Standalone stop | `/home/hatch/workspace/oxbf-proxy/stop-oxbf.sh` |
| Standalone status | `/home/hatch/workspace/oxbf-proxy/status-oxbf.sh` |
| Smoke test | `cd /home/hatch/workspace/oxbf-proxy && ./venv/bin/python smoke_test.py` |
| Reinstall deps | `cd /home/hatch/workspace/oxbf-proxy && ./venv/bin/pip install -r requirements.txt` |
| Config check | `cd /home/hatch/workspace/oxbf-proxy && ./venv/bin/python -c "import config; config.validate(); print('ok')"` |

## Procedure

### First-time setup

1. Copy the template and set mode 600.
   ```
   terminal(command="cp /home/hatch/workspace/oxbf-proxy/.env.example /home/hatch/workspace/oxbf-proxy/.env && chmod 600 /home/hatch/workspace/oxbf-proxy/.env", timeout=30)
   ```
   **Done when:** `.env` exists with mode 600.

2. Fill in `OXBF_BOT_TOKEN`, `OXBF_ADMIN_IDS`, `OXBF_2CAPTCHA_API_KEY`, `OXBF_TEMPMAIL_DOMAIN`.
   Use the `patch` tool on the `.env` file. **Never** print secret values in chat,
   logs, or reports — refer to them as `[REDACTED]`.
   **Done when:** `config.validate()` exits 0 (step 4).

3. Verify the owner ID matches the owner's Telegram user_id.
   ```
   terminal(command="cd /home/hatch/workspace/oxbf-proxy && ./venv/bin/python -c \"import config; print(config.ADMIN_IDS)\"", timeout=60)
   ```
   **Done when:** the printed list contains the owner's numeric id.

4. Validate config without starting the bot.
   ```
   terminal(command="cd /home/hatch/workspace/oxbf-proxy && ./venv/bin/python -c \"import config; config.validate(); print('config ok')\"", timeout=60)
   ```
   **Done when:** prints `config ok`. A `RuntimeError` listing missing keys means
   step 2 is incomplete.

5. Run the offline smoke test.
   ```
   terminal(command="cd /home/hatch/workspace/oxbf-proxy && ./venv/bin/python smoke_test.py", timeout=240)
   ```
   **Done when:** last line is `RESULT: ALL PASS`.

6. Start the bot and confirm it is alive.
   ```
   terminal(command="systemctl enable --now oxbf-proxy && sleep 5 && systemctl is-active oxbf-proxy", timeout=90)
   ```
   **Done when:** `active` and the log shows the bot polling Telegram.

   The unit ships **disabled** so a missing `.env` never crash-loops the box.
   `RestartPreventExitStatus=1` stops systemd from retrying a config error.
   Until the real token is in place the service stays `inactive` by design.

### Daily operation

7. Confirm liveness before reporting status — `systemctl is-active` plus a
   fresh log tail, never a remembered state.
   ```
   terminal(command="systemctl is-active oxbf-proxy; tail -n 20 /home/hatch/workspace/oxbf-proxy/data/oxbf.log", timeout=60)
   ```
   **Done when:** `active` and the last log line is recent.

### Reinstall after a code change

8. Reinstall deps and re-run the smoke test before restarting.
   ```
   terminal(command="cd /home/hatch/workspace/oxbf-proxy && ./venv/bin/pip install -r requirements.txt && ./venv/bin/python smoke_test.py && systemctl restart oxbf-proxy", timeout=300)
   ```
   **Done when:** `RESULT: ALL PASS` and `systemctl is-active` returns `active`.

## Pitfalls

- **`config.validate()` raises at startup** when `OXBF_BOT_TOKEN` is still the
  placeholder `MASUKIN_TOKEN_BOT_LO`. That is deliberate fail-fast behavior, not
  a crash bug.
- **The bot needs a reachable Telegram API.** Under the VM egress proxy, set
  `http_proxy`/`https_proxy` (the systemd unit already does) or the bot will
  time out on `getUpdates`.
- **`data/oxbf.db` is the only state store.** Deleting it resets members,
  nodes, prefs, and the vault table. Back it up before experiments.
- **Standalone and systemd runs must not overlap.** The pidfile and the unit
  both track the same app; stop one before starting the other.
- **`venv/` is not portable** — it holds absolute paths. Recreate it on a new VM
  with `python3.12 -m venv venv` before reinstalling deps.
- **Captcha and tempmail are paid/third-party services.** If auto-register
  fails, the failure is upstream of the app, not a bug in the bot.
- **Do not log or echo `.env`.** `config.captcha_info()` already returns a
  masked key — use that instead of reading the raw value.

## Verification

The install is complete and correct when ALL of these hold:

- `./venv/bin/python smoke_test.py` ends with `RESULT: ALL PASS`
- `config.validate()` exits 0
- `systemctl is-active oxbf-proxy` returns `active`
- `tail -n 5 data/oxbf.log` shows the bot polling, with no traceback
- `.env` mode is 600 and contains no placeholder values
- `pip freeze` inside the venv lists every entry in `requirements.txt`
