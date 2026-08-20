---
name: gtm-motion
description: >-
  Router for outbound GTM with Grok Bot — Instantly email, HeyReach LinkedIn,
  lists, replies, and daily ops. Use when planning or running cold outreach,
  prospecting, sequences, or a GTM motion in this repo.
---

# GTM motion

Entry point for outbound work in this repository. Sequential setup lives in `playbooks/`. Standing rules live in `AGENTS.md`. Read those; do not fork the rules here.

## Route

| Need | Skill | Playbook |
|------|-------|----------|
| Install CLIs on Grok Bot / local-exec / MCP | [grokbot-runtime](../grokbot-runtime/SKILL.md) | 00 |
| ICP / offer / proof missing | — | 01 (`company.md`) |
| DNS, warmup, blocklist, inbox health | [deliverability](../deliverability/SKILL.md) | 02 |
| Draft or review copy | [copywriting](../copywriting/SKILL.md) | 04 / 05 |
| Build or score a list | [list-building](../list-building/SKILL.md) | 03 |
| Find people / emails (ZoomInfo `gtm`, Prospeo, Ocean, LeadMagic, Clay) | [data-sources](../data-sources/SKILL.md) | 03-data-sources |
| Instantly campaign | [instantly-launch](../instantly-launch/SKILL.md) | 04 |
| HeyReach campaign | [heyreach-launch](../heyreach-launch/SKILL.md) | 05 |
| Unread replies, classify, draft, booking URL | [replies](../replies/SKILL.md) | 06 |
| Which CLI is installed (npm/bin/health) | — | [cli-stack.md](../../playbooks/cli-stack.md) |
| Scoreboard, pause, overnight | [daily-ops](../daily-ops/SKILL.md) | 07 |

## Order

00 prerequisites → 01 company → 02 infrastructure → 03 list → 04 email and/or 05 LinkedIn → 06 replies → 07 daily ops.

Skip a channel if that API key is unset. Do not skip 02 on the email path.

## Outcome

Done means interested conversations and (if they asked) meetings, with suppression respected. Not "CLI returned 200."
