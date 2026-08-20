---
name: data-sources
description: >-
  Chooses and runs a list/enrichment CLI: ZoomInfo GTM CLI (gtm), Prospeo,
  Ocean.io, LeadMagic, or Clay. Use when building an ICP list, finding emails,
  enriching companies, or the operator mentions ZoomInfo, Prospeo, Ocean, Clay,
  or LeadMagic.
---

# Data sources

Playbook: `playbooks/03-data-sources.md`. Standing credit/approval rules: `AGENTS.md`.

## Choose one

Read `company.md` Data sources. Else first healthy CLI. Do not call every provider.

| If this works | Use |
|---------------|-----|
| `gtm auth whoami` | ZoomInfo **GTM CLI** (`gtm`) — [gtm.ai/docs/cli](https://gtm.ai/docs/cli) |
| `prospeo account info` | `prospeo` (`prospeo-cli`, `PROSPEO_API_KEY`) |
| `ocean credits balance` | `ocean` (`ocean-agent-cli`, `OCEAN_API_TOKEN`) |
| `leadmagic status` | `leadmagic` (`leadmagic-agent-cli`, `LEADMAGIC_API_KEY`) |
| `clay tables list` (non-empty) | `clay` (`clay-gtm-cli`) — webhook tables only |
| none | Operator file in `lists/` |

**ZoomInfo is `gtm`, not `zoominfo`.** Package: `@zoominfo/gtm-ai-cli`. Auth: `gtm auth login` (browser OAuth → `~/.config/gtm-ai/`). Search is free; enrich spends bulk credits. Always `gtm lookup --field …` before filtered search (422 on unknown strings).

## Hard rules

- Map into Instantly/HeyReach shapes in playbook 03 before any campaign add
- Ask before enrich/reveal/bulk on **>10** records
- Ocean `reveal emails` / `reveal phones` require `--webhook-url` — skip without one
- Prospeo **search does not include email**; `person enrich` / `bulk-enrich` after
- LeadMagic: cheapest call first; do not start with `email-to-profile` (10 credits) or `find-mobile` (5)
- Clay `--wait` needs `clay listen start` or a configured callback URL
- Do not guess emails. Do not scrape LinkedIn
