---
name: copywriting
description: >-
  Writes and reviews cold email and LinkedIn copy — hook, bridge, low-friction
  CTA, no fluff, no invented proof. Use when drafting sequences, connection
  notes, or follow-ups.
---

# Copywriting

Prospects are strangers. Relevant, not relational. Examples: `examples/copy-examples.md`.

## Never write

"I hope this finds you well", empty flattery, alumni small talk, "I'll be in your city", long product novels, fabricated metrics.

## Structure (email)

1. `Hi {{firstName}},`
2. Hook — one sentence about *their* situation
3. Bridge — pain + **user-supplied** proof
4. Low-friction CTA — "mind if I send X?" not "15 minutes Tuesday?"

50–125 words. Mobile-scannable. Easy out.

## Merge tags

| Surface | Lead fields | Copy tags |
|---------|-------------|-----------|
| Instantly | `first_name`, `company_name` | `{{firstName}}`, `{{companyName}}` (confirm in workspace) |
| HeyReach | `firstName`, `companyName` | `{{firstName}}`, `{{companyName}}` |

Wrong casing ships literal braces. Confirm before activate/start.

## LinkedIn

Connection note: one line, no links, no pitch. Follow-up after accept: same offer as email, even shorter.

## Proof

Only from `company.md` or the operator. No proof → omit the number. Do not invent one.

## QA

- [ ] Tags match the sequencer
- [ ] No fluff
- [ ] Hook is specific
- [ ] CTA is one-word-reply easy
- [ ] No links in email 1 unless opted in
- [ ] Under ~125 words (email) / ~300 chars (LinkedIn note)
