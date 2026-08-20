---
name: instantly-launch
description: >-
  Creates and launches Instantly cold email campaigns via instantly-cli.
  Use when setting up sequences, adding leads, activating, or diagnosing
  sending status.
---

# Instantly launch

Playbook: `playbooks/04-email.md`. CLI: `instantly`. Pretty: `--output pretty`. Help is source of truth for flags.

## Sequence

1. Deliverability READY (or operator accepted NEEDS WORK)
2. `campaigns create` as **draft** — `--text-only --no-open-tracking --no-link-tracking --stop-on-reply`
3. `leads bulk-add --skip-if-in-workspace --skip-if-in-campaign`
4. Show copy + counts + senders. **Wait**
5. `campaigns activate ID` only after approval
6. `campaigns sending-status ID` if it does not send

## Health

```bash
instantly campaigns list --limit 5 --output pretty
instantly accounts list --output pretty
instantly analytics campaign-overview --output pretty
```

## Approval

Activate, pause of a live campaign, and live `email reply` need the operator.
