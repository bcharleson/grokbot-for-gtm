# Security

## Secrets

Never commit API keys, tokens, cookies, or customer data to this repository.

- Copy `.env.example` → `.env` and keep secrets local
- Copy `company.example.md` → `company.md` (gitignored) for your ICP and offer
- Do not paste keys into Grok Bot chat, GitHub issues, or skill files
- On Grok Bot, store keys as environment variables on the Bot computer — not in `company.md`

If you accidentally commit a secret:

1. Revoke and rotate the key in the provider dashboard immediately
2. Remove it from git history before treating the repo as safe

## LinkedIn

Do not put LinkedIn session cookies in this repo. Use HeyReach's official API (`heyreach-cli`) for LinkedIn automation. Cookie-based LinkedIn CLIs are out of scope here.

## Reporting

If a playbook or skill encourages unsafe credential handling, open a GitHub issue with the `security` label.
