---
name: intake
description: >-
  Interviews the operator to fill company.md before any outbound work.
  Use at session start, when company.md is missing or blank, or when ICP,
  proof, channels, data source, or booking tool are unknown.
---

# Intake

Playbook: `playbooks/00-intake.md`. Standing rule: ask; do not invent.

Run the seven batches in order. Wait between batches. Write answers to `company.md`. Read back. Stop until they confirm.

Closed sets (do not add a vendor they did not pick):

- Send: Instantly, HeyReach, optionally EmailBison / Smartlead
- List: file, gtm, prospeo, ocean, leadmagic, clay, seamless, trigify, contactout
- Meetings: Calendly, Cal.com, or topcal (all three: slots then book), or a pasted URL — replies only
- CRM: none or a row in `playbooks/cli-stack.md`

If a field is unknown, write `unknown`. Empty proof means copy has no metric.
