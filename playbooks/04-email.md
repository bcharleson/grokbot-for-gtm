# 04 — Email (Instantly)

Goal: a **draft** Instantly campaign with a 3-step plain-text sequence, leads loaded, senders attached. Activate only after the operator says so.

Load `.grok/skills/copywriting/SKILL.md` and `.grok/skills/instantly-launch/SKILL.md`.

## Preflight

- Playbooks 00–03 passed for the email path
- Deliverability status READY (or operator accepted NEEDS WORK)
- Copy uses proof from `company.md` only
- Email 1 has no links unless operator opted in

## Create (draft)

Confirm flags with `instantly campaigns create --help`. Typical shape:

```bash
instantly campaigns create \
  --name "ICP outbound — YYYY-MM-DD" \
  --text-only \
  --no-open-tracking \
  --no-link-tracking \
  --stop-on-reply \
  --daily-limit 25 \
  --email-gap 10 \
  --email-list '["you@outreach-domain.com"]' \
  --sequences '[{"steps":[{"type":"email","delay":0,"variants":[{"subject":"{{firstName}} — {{hook fragment}}","body":"<div>plain text body</div>"}]},{"type":"email","delay":3,"variants":[{"subject":"{{firstName}}","body":"<div>follow-up</div>"}]},{"type":"email","delay":4,"variants":[{"subject":"{{firstName}}","body":"<div>breakup</div>"}]}]}]' \
  --output pretty
```

Save the returned campaign id. Do not activate yet.

Instantly merge tags in the body: `{{firstName}}`, `{{companyName}}` unless the workspace docs say otherwise. Lead JSON still uses `first_name`.

## Load leads

```bash
instantly leads bulk-add \
  --campaign-id CAMP_ID \
  --leads "$(cat lists/icp-batch-1.json)" \
  --skip-if-in-workspace \
  --skip-if-in-campaign \
  --output pretty
```

## Attach / verify senders

If `--email-list` was not set at create:

```bash
instantly campaigns get CAMP_ID --output pretty
instantly accounts list --output pretty
```

The campaign must reference warmed, healthy accounts only.

## Operator review

Show:

1. Subject + body for all 3 steps (plain text)
2. Lead count
3. Sender list
4. Daily cap and schedule
5. Deliverability status

Wait for **activate**.

```bash
instantly campaigns activate CAMP_ID --output pretty
instantly campaigns sending-status CAMP_ID --output pretty
```

Next: [05-linkedin.md](05-linkedin.md) if LinkedIn is on, else [06-replies.md](06-replies.md)
