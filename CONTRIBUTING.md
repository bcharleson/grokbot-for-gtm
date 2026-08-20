# Contributing

This repo is a **business-agnostic** Grok Bot playbook. Keep it that way.

## What belongs here

- Playbooks, skills, and examples with no client names, private metrics, or proprietary sequences
- CLI command examples that match published `instantly-cli` / `heyreach-cli` (verify flags before documenting)
- Improvements to Grok Bot setup (VM CLI install, local-exec, remote MCP) without real credentials

## What does not belong here

- API keys, `.env` files, `company.md`, campaign IDs, prospect lists
- Invented case-study metrics presented as fact
- LinkedIn cookie/session tooling
- Vendor lock-in that makes Instantly or HeyReach mandatory for reading the playbooks (they are the default tools; the motion should still make sense without them)

## Where to put things

| Change | Home |
|--------|------|
| Sequential setup step | `playbooks/NN-*.md` |
| Task procedure the agent should load | `.grok/skills/<name>/SKILL.md` |
| Standing rule (approval, secrets, no invented proof) | `AGENTS.md` only |
| Fictional copy / lists | `examples/` |

One home per fact. Skills may link to playbooks; do not paste the same checklist into both.

## Adding a skill

1. Create `.grok/skills/<skill-name>/SKILL.md` with `name` and `description` frontmatter
2. Route to it from `.grok/skills/gtm-motion/SKILL.md` if it is part of the motion
3. Update the skill table in `README.md`

## Pull requests

1. Fork and branch from `main`
2. Keep changes scoped
3. Confirm no secrets or proprietary content
4. Open a PR with what changed and why
