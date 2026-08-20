# 03 — List

Goal: 25–100 real people who match the ICP, in a JSON file the operator owns. Not in git.

Load `.grok/skills/list-building/SKILL.md`.

## Rules

- Operator supplies the list (CSV/JSON they export from their CRM, Clay, Apollo, etc.)
- `examples/sample-leads.json` is fictional. Never send it
- Drop real files in `lists/` (gitignored) e.g. `lists/icp-batch-1.json`
- Every row needs enough to send on the chosen channel:
  - Email: `email`, `first_name`, `company_name`
  - LinkedIn: `profileUrl` or `profile_url`, `firstName`, `companyName`
- Suppress anyone on the blocklist, current customers, or disqualifiers in `company.md`

## Suggested Instantly lead shape

```json
[
  {
    "email": "alex@example.com",
    "first_name": "Alex",
    "last_name": "Rivera",
    "company_name": "Example Co",
    "website": "https://example.com"
  }
]
```

Instantly API fields are snake_case. Do not put merge tags in this file.

## Suggested HeyReach lead shape

```json
[
  {
    "firstName": "Alex",
    "lastName": "Rivera",
    "profileUrl": "https://www.linkedin.com/in/example",
    "companyName": "Example Co",
    "position": "VP Operations"
  }
]
```

## Bot job

1. Validate required fields
2. Count rows, titles vs ICP, domains vs suppression
3. Report: `N eligible / N skipped (reasons)`
4. Do not enrich by guessing emails. If enrichment tools are configured, see playbook 08

First live batch: **25–50**. Not 5,000.

Next: [04-email.md](04-email.md) and/or [05-linkedin.md](05-linkedin.md)
