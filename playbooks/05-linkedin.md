# 05 — LinkedIn (HeyReach)

Goal: a **DRAFT** HeyReach campaign (connection request + message on accept) on the same ICP. `start` only after the operator says so.

Load `.grok/skills/heyreach-launch/SKILL.md`. Cookie-based LinkedIn CLIs are out of scope.

## Preflight

- `heyreach status` works
- `heyreach accounts list` returns at least one sender
- List has LinkedIn profile URLs
- Copy is short, no pitch dump, same offer as email (not a duplicate paragraph)

Stay inside HeyReach and LinkedIn daily limits from `company.md`.

## List + campaign

```bash
heyreach lists create --name "ICP LinkedIn — YYYY-MM-DD" --pretty
# save id

heyreach lists add-leads --list-id LIST_ID --leads-json "$(cat lists/icp-batch-1-linkedin.json)" --pretty

heyreach campaigns create \
  --name "ICP LinkedIn — YYYY-MM-DD" \
  --list-id LIST_ID \
  --account-ids "SENDER_ID" \
  --schedule-json '{"dailyStartTime":"09:00:00","dailyEndTime":"17:00:00","timeZoneId":"America/New_York"}' \
  --sequence-json '{
    "nodeType": "CONNECTION_REQUEST",
    "actionDelay": 3,
    "actionDelayUnit": "HOUR",
    "payload": {
      "messages": ["Hi {{firstName}}, saw your work at {{companyName}} — would like to connect."],
      "fallbackMessage": "Hi, would like to connect."
    },
    "conditionalNode": {
      "nodeType": "MESSAGE",
      "actionDelay": 1,
      "actionDelayUnit": "DAY",
      "payload": {
        "messages": ["Thanks for connecting, {{firstName}}. {{one-line offer from company.md}} If useful I can send a short write-up — want me to?"],
        "fallbackMessage": "Thanks for connecting. Happy to share a short write-up if useful."
      },
      "unconditionalNode": { "nodeType": "END", "actionDelay": 3, "actionDelayUnit": "HOUR" },
      "conditionalNode": { "nodeType": "END", "actionDelay": 3, "actionDelayUnit": "HOUR" }
    },
    "unconditionalNode": { "nodeType": "END", "actionDelay": 3, "actionDelayUnit": "HOUR" }
  }' \
  --pretty
```

Create returns `{campaignId}` in **DRAFT**. `resume` will reject drafts — use `start`.

Capture a known-good sequence from an existing campaign if the JSON above fails validation:

```bash
heyreach campaigns get-sequence --campaign-id EXISTING --pretty
```

## Operator review

Show connection note, follow-up message, sender accounts, list size. Wait for **start**.

```bash
heyreach campaigns start --campaign-id CAMP_ID --pretty
heyreach stats overview --campaign-ids CAMP_ID --pretty
```

Pause (the only halt — HeyReach has no delete/cancel):

```bash
heyreach campaigns pause --campaign-id CAMP_ID --pretty
```

Next: [06-replies.md](06-replies.md)
