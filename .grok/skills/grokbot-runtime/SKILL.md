---
name: grokbot-runtime
description: >-
  How Grok Bot should run Instantly and HeyReach CLIs — Bot computer vs
  local-exec vs remote MCP. Use when installing tools, debugging auth, or
  configuring MCP for Grok Bot.
---

# Grok Bot runtime

Grok Bot is not Grok Build. It has a Linux VM in the cloud. It can optionally run commands on the operator's Mac (local-exec) after they approve.

## Preferred path

Install CLIs **on the Bot computer** so overnight jobs survive a closed laptop.

```bash
npm install -g instantly-cli heyreach-cli
# list/enrich — only what you use:
# npm i -g @zoominfo/gtm-ai-cli prospeo-cli ocean-agent-cli leadmagic-agent-cli clay-gtm-cli
export INSTANTLY_API_KEY
export HEYREACH_API_KEY
instantly campaigns list --limit 1 --output pretty
heyreach status --pretty
```

ZoomInfo: `gtm auth login` (browser OAuth on this computer), then `gtm auth whoami`. Token lives in `~/.config/gtm-ai/`, not an env var.

From this repo after `npm install`, `npx instantly` and `npx heyreach` also work.

## Local-exec

Use when keys must stay on the Mac. Every command is approved by the operator. Do not assume overnight continuity.

## MCP

| Kind | Grok Bot | Grok Build |
|------|----------|------------|
| stdio (`instantly mcp`) | **No** — Bot cannot attach local stdio | Yes |
| Remote HTTP MCP | Yes, if the operator hosts a URL | Yes |

Do not add stdio MCP as a Grok Bot plugin. Use the CLI.

Instantly pretty-print: `--output pretty`. HeyReach / Prospeo / Ocean / LeadMagic: `--pretty`. ZoomInfo `gtm`: `-f json|jsonl|csv|table`. Default for the bcharleson CLIs is compact JSON.

## Secrets

Never echo `$INSTANTLY_API_KEY` or `$HEYREACH_API_KEY`. `bash scripts/check-setup.sh` reports presence and length only.
