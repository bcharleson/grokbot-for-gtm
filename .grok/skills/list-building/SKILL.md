---
name: list-building
description: >-
  Builds and validates an ICP outreach list for Instantly and HeyReach.
  Use when importing leads, scoring fit, or checking suppression.
---

# List building

Playbook: `playbooks/03-list.md`. The operator owns the list. This skill validates it.

## Do

- Require email (Instantly) and/or LinkedIn URL (HeyReach)
- Match titles, size, geo, and disqualifiers in `company.md`
- Drop competitors, customers, and blocklist domains
- First batch 25–50

## Do not

- Send `examples/sample-leads.json`
- Guess emails
- Commit real lists (put them in `lists/`, gitignored)
- Enrich unless playbook 08 tools are configured

## Report

`eligible / skipped (reason counts)` then wait before bulk-add.
