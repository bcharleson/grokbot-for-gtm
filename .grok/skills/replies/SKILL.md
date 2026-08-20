---
name: replies
description: >-
  Classifies Instantly and HeyReach replies and drafts responses. Use when
  handling unread inbox, positive replies, OOO, unsubscribes, or booking.
---

# Replies

Playbook: `playbooks/06-replies.md`. Draft always; send only with approval.

## Pull

```bash
instantly email list --email-type reply --is-read false --output pretty
heyreach inbox list --seen false --pretty
```

## Labels

interested · question · timing · referral · ooo · unsubscribe/angry · not-a-fit

## Behavior

- Interested: send the asset you promised; meeting link only if they asked or `company.md` says so
- Unsubscribe / angry: stop the lead, no clever close
- OOO: wait
- No new claims beyond `company.md`

Calendar links belong in **replies**, not email 1. Scheduler is whatever intake wrote.

If **topcal**: you can agent-book (slots GET → invitee OTP → confirm). Full loop in playbook 06. Public URLs stay on `https://topcal.ai/...`.

If **Calendly** or **Cal.com**: paste their URL; optional `calendly users me` / `calcom profile me`.

Do not introduce a booking product they did not set.
