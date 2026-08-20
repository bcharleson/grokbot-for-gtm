# 00 — Prerequisites

Goal: the Bot can talk to at least one channel. No campaigns yet.

## Operator checklist

- [ ] Grok Bot desktop app (or Grok Build) signed in
- [ ] Node.js 18+ on the computer that will run CLIs (Bot VM recommended)
- [ ] This repo cloned onto that computer
- [ ] Instantly workspace **or** HeyReach workspace (both is better)
- [ ] Sending mailboxes already connected in Instantly (warmup can still be ramping)
- [ ] LinkedIn accounts already connected in HeyReach (if using LinkedIn)
- [ ] API keys in `.env` or exported in the shell — never in chat
- [ ] Optional list CLI: ZoomInfo `gtm auth login`, and/or Prospeo / Ocean / LeadMagic / Clay installed on the same computer

## Bot checklist

```bash
cd /path/to/grokbot-for-gtm
npm install
bash scripts/check-setup.sh
```

Then, if keys are present:

```bash
# Instantly — expect JSON, not an auth error
instantly campaigns list --limit 1 --output pretty

# HeyReach
heyreach status --pretty
heyreach accounts list --pretty
```

## Grok Bot computer notes

The Bot computer is a managed Linux VM. `npm install -g instantly-cli heyreach-cli` is the default.

Local-exec (Bot runs commands on your Mac) is fine for a demo. For overnight reply handling, install the CLIs **on the Bot computer** so work continues when the laptop is closed.

Do not add stdio MCP servers to Grok Bot. See `.grok/skills/grokbot-runtime/SKILL.md`.

## Pass / fail

| Result | Meaning |
|--------|---------|
| `check-setup.sh` exits 0 and at least one health check returns JSON | Go to playbook 01 |
| Auth error | Key missing, revoked, or wrong env var name. Stop |
| CLI not found | Install globally or use `npx instantly` / `npx heyreach` from this repo after `npm install` |

Next: [01-company.md](01-company.md)
