# 07 — Daily ops

Goal: a scoreboard and a few safe maintenance actions. This is the overnight job Grok Bot is good at.

Load `.grok/skills/daily-ops/SKILL.md`.

## Morning probe (no writes)

```bash
instantly analytics campaign-overview --output pretty
instantly email unread-count --output pretty
heyreach stats overview --pretty
heyreach inbox list --seen false --limit 20 --pretty
```

Report:

- sent / replies / bounces (email)
- connections / replies (LinkedIn)
- unread count
- threads that look interested (link to classify in playbook 06)
- anything BLOCKED (account paused, sending-status errors)

## Allowed without extra approval

- Listing campaigns, analytics, unread
- Drafting reply text
- Adding to blocklist when someone unsubscribes (if Instantly did not already)

## Still needs approval

- Activate / pause / start live campaigns
- Sending replies
- Raising daily caps
- Bulk-adding a new list

## Pause rules (recommend, then ask)

Recommend pause if:

- Bounce rate is high relative to sent (operator confirms Instantly's current threshold)
- An account fails vitals
- Reply quality is all "wrong person" — list is off ICP

```bash
instantly campaigns pause CAMP_ID --output pretty
heyreach campaigns pause --campaign-id CAMP_ID --pretty
```

## Monday scoreboard

One short message to the operator:

```
Channel    sent   replies   meetings   notes
Email      n      n         n          …
LinkedIn   n      n         n          …
Next batch: yes/no (why)
```

No vanity open rates as the headline. Replies and meetings are the headline.

Optional stack (CRM, Clay, calendar): [08-optional-stack.md](08-optional-stack.md)
