---
name: daily-ops
description: >-
  Daily outbound ops for Grok Bot — unread counts, analytics, pause
  recommendations, Monday scoreboard. Use for overnight or morning check-ins.
---

# Daily ops

Playbook: `playbooks/07-daily-ops.md`. Reads are free; writes follow AGENTS.md.

## Probe

```bash
instantly analytics campaign-overview --output pretty
instantly email unread-count --output pretty
heyreach stats overview --pretty
heyreach inbox list --seen false --limit 20 --pretty
```

Headline metrics: **replies and meetings**, not opens.

## Recommend pause, then ask

High bounces, failed vitals, or "wrong person" flood.

Do not raise sending caps or activate new campaigns as part of daily ops unless the operator asked.
