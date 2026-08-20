---
name: deliverability
description: >-
  Cold email deliverability — plain text, SPF/DKIM/DMARC, warmup, SEGs.
  Use before launching Instantly campaigns, when inbox placement is poor,
  or when reviewing sending domains and DNS.
---

# Deliverability

Legitimate cold email is filtered like spam. Authentication and format first; copy second. Playbook: `playbooks/02-infrastructure.md`.

## Hard stop

Missing or broken **SPF, DKIM, or DMARC** on the sending domain → status **BLOCKED**. Do not activate.

## Default message format

- Plain text
- No links, images, or attachments on email 1
- Links only if the operator opts in; prefer sending assets after a positive reply

## Hygiene

- Dedicated outreach domain when possible
- Warm new inboxes; no day-one volume spikes
- From domain aligned with DKIM
- Pull failing accounts off campaigns (`instantly accounts test-vitals EMAIL`)

## Recipient side

Enterprise ICP ⇒ assume a SEG (Proofpoint, Mimecast, Barracuda). Stricter auth, domain age, and no tricks.

## Audit output

```markdown
## Deliverability Assessment
### Status: READY | NEEDS WORK | BLOCKED
### DNS: SPF / DKIM / DMARC
### Inboxes: warmup, vitals
### Format: plain text / links
### Required actions
```
