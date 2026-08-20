---
name: heyreach-launch
description: >-
  Creates and starts HeyReach LinkedIn campaigns via heyreach-cli. Use when
  building lists, connection sequences, inbox, or LinkedIn stats.
---

# HeyReach launch

Playbook: `playbooks/05-linkedin.md`. CLI: `heyreach`. Pretty: `--pretty`. No cookie-based LinkedIn tools.

## Sequence

1. `heyreach status` and `accounts list`
2. `lists create` + `lists add-leads`
3. `campaigns create` → **DRAFT** (returns `campaignId`)
4. Show connection note + follow-up. **Wait**
5. `campaigns start --campaign-id ID` — not `resume` (resume rejects DRAFT)
6. Halt with `campaigns pause` (no delete/cancel in the public API)

If `--sequence-json` fails validation, copy shape from `campaigns get-sequence` on a working campaign.

## Inbox

```bash
heyreach inbox list --seen false --pretty
heyreach stats overview --pretty
```

Live `inbox send` needs approval. `campaigns stop-lead` for unsub / angry / wrong-person.
