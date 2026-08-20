# 02 — Infrastructure

Goal: email that can land. Skip this playbook only if the operator is LinkedIn-only.

Load `.grok/skills/deliverability/SKILL.md` while you work this.

## Sending domain

Cold email should use a **dedicated outreach domain or subdomain**, not the primary marketing domain.

Required DNS on that domain:

| Record | Why |
|--------|-----|
| SPF | Who may send |
| DKIM | Signature |
| DMARC | Policy on failures |

If any of the three is missing → **BLOCKED**. Do not activate campaigns.

The operator checks DNS in their registrar or Instantly's account vitals. The Bot can run:

```bash
instantly accounts list --output pretty
instantly accounts test-vitals you@outreach-domain.com --output pretty
```

Confirm any extra flags with `instantly accounts --help`.

## Warmup

New inboxes send a little, then more. A volume spike on day one is how you earn spam.

- Enable warmup on every new Instantly account before a campaign uses it
- Do not attach an inbox that is paused, disconnected, or failing vitals
- Daily campaign cap in `company.md` must be at or under what warmup and Instantly recommend for that inbox age

```bash
instantly accounts warmup-enable --account-ids "ACCOUNT_ID"
instantly analytics warmup --emails "you@outreach-domain.com" --output pretty
```

## Instantly blocklist

Load competitor and customer domains from `company.md` **before** importing a list.

```bash
# Example shape only — use the operator's domains
instantly blocklist create --value competitor.com --output pretty
```

Confirm flags with `instantly blocklist create --help`.

## HeyReach (if LinkedIn is on)

```bash
heyreach accounts list --pretty
```

You need at least one connected LinkedIn account. Caps stay inside HeyReach/LinkedIn limits from `company.md`. This playbook does not raise those limits.

## Pass / fail

Status for the email path: **READY | NEEDS WORK | BLOCKED** using the deliverability skill's output format.

Do not start playbook 04 until status is READY, or the operator explicitly accepts NEEDS WORK (never BLOCKED).

Next: [03-list.md](03-list.md)
