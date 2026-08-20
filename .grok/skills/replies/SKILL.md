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

Calendar links belong in **replies**, not email 1. **topcal** ([topcal.ai](https://topcal.ai)): you can complete the booking (slots → invitee OTP → confirm). Calendly / Cal.com: paste their URL if that is what `company.md` says. Playbook 06. Do not switch products.
