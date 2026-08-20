# Grok Bot for GTM

**Give Grok Bot this repo and it can run a complete outbound motion** — research a list, launch cold email, run LinkedIn in parallel, handle replies, and log meetings — without you pasting 156 CLI commands into chat.

This is a playbook + skill pack. You bring your ICP, offer, sending accounts, and API keys.

Companion to [cursor-for-gtm-demo](https://github.com/bcharleson/cursor-for-gtm-demo). That repo teaches Cursor skills for copy and deliverability. This one is the **operating system for Grok Bot**: install the agent-native CLIs on the Bot's computer, fill one company file, and walk a numbered motion.

```
npm install
cp company.example.md company.md   # fill this — it is gitignored
cp .env.example .env               # keys stay local
```

Then paste [SETUP-PROMPT.md](SETUP-PROMPT.md) to a new Grok Bot.

---

## What you get

| Piece | Path | Purpose |
|-------|------|---------|
| Standing rules | [AGENTS.md](AGENTS.md) | How the Bot must behave (no invented proof, no send without preflight) |
| First message | [SETUP-PROMPT.md](SETUP-PROMPT.md) | Paste this to a new Bot |
| Your business | `company.md` (from [company.example.md](company.example.md)) | ICP, offer, proof, CTA — the only file you customize |
| Numbered motion | [playbooks/](playbooks/) | 00 → 07, plus data sources |
| Skills | [.grok/skills/](.grok/skills/) | Task playbooks Grok Build / the Bot can load |
| Fictional examples | [examples/](examples/) | Copy patterns and a fake company. Never real data |
| Setup check | `npm run check` | Confirms Node, CLIs, env vars, `company.md` — does not print secrets |

### The motion

```
0. Prerequisites     Node 18+, Instantly and/or HeyReach accounts, Grok Bot
1. Company file      ICP, offer, proof, CTA  →  company.md
2. Infrastructure    DNS (SPF/DKIM/DMARC), warmup, sender accounts
3. List              25–100 people (file, or Prospeo / Ocean / LeadMagic / Clay / ZoomInfo `gtm`)
4. Email             Instantly campaign, plain text, low-friction CTA
5. LinkedIn          HeyReach sequence on the same people (optional)
6. Replies           Classify, draft, book, log. Human approves sends
7. Daily ops         Unread inbox, pause duds, Monday scoreboard
```

A finished run looks like: **interested replies in Instantly, accepted connections in HeyReach, meetings on a calendar, records in your CRM.** Not `campaigns list` succeeding.

---

## Why Grok Bot (not just Cursor)

Grok Bot has its own Linux computer in the cloud. Jobs keep going when you close the laptop.

| Path | Use when | How |
|------|----------|-----|
| **CLI on the Bot computer** (recommended) | Always-on outbound | `npm i -g instantly-cli heyreach-cli` then export API keys on the VM |
| **Local exec** | Keys or files should stay on your Mac | Bot asks permission; you approve each command |
| **Remote MCP plugin** | Hosted HTTP MCP | Grok Bot cannot attach **stdio** MCP from your laptop. Do not add `instantly mcp` as a local server |

Grok Build (the coding TUI) *can* use stdio MCP. Grok Bot cannot. This repo treats the **CLI binary + JSON output** as the contract so both work.

**Send path (this repo's `npm install`):**

- [instantly-cli](https://github.com/bcharleson/instantly-cli) — cold email
- [heyreach-cli](https://github.com/bcharleson/heyreach-cli) — LinkedIn via HeyReach's public API

**List / enrich (install only what you have keys for):**

- ZoomInfo [GTM CLI](https://gtm.ai/docs/cli) (`gtm`, npm `@zoominfo/gtm-ai-cli`) — OAuth, search free, enrich uses bulk credits
- [prospeo-cli](https://github.com/bcharleson/prospeo-cli) — person/company search + enrich
- [ocean-agent-cli](https://github.com/bcharleson/ocean-agent-cli) — Ocean.io search + enrich
- [leadmagic-agent-cli](https://github.com/bcharleson/leadmagic-agent-cli) — email find/validate, roles, job-change
- [clay-gtm-cli](https://github.com/bcharleson/clay-gtm-cli) — fire **your** Clay webhook tables

See [playbooks/03-data-sources.md](playbooks/03-data-sources.md). Other tools (CRM, calendar): [playbooks/08-optional-stack.md](playbooks/08-optional-stack.md).

---

## Human setup (15 minutes)

### 1. Accounts

You need at least one of:

- Instantly workspace + API key ([Integrations](https://app.instantly.ai/app/settings/integrations))
- HeyReach workspace + Public API key (Settings → Integrations)

Plus sending infrastructure Instantly/HeyReach already know about (warmed mailboxes, connected LinkedIn accounts). This repo does not provision inboxes or LinkedIn seats.

### 2. Clone onto the Bot computer (or your laptop)

```bash
git clone https://github.com/bcharleson/grokbot-for-gtm.git
cd grokbot-for-gtm
npm install
cp company.example.md company.md
cp .env.example .env
```

Fill `company.md`. Fill `.env`. Never commit either file.

### 3. Install CLIs globally on the Bot computer

```bash
npm install -g instantly-cli heyreach-cli
set -a && source .env && set +a

# Instantly health check (compact JSON)
instantly campaigns list --output pretty --limit 1

# HeyReach health check
heyreach status --pretty
```

If a command fails, the Bot should stop and tell you — not invent a campaign.

### 4. Hand the Bot the repo

Paste the contents of [SETUP-PROMPT.md](SETUP-PROMPT.md). Tell it the folder path. Ask it to run `npm run check`, then playbook 00.

---

## What the Bot is allowed to do

See [AGENTS.md](AGENTS.md). Short version:

- **May:** read this repo, check setup, draft copy, create **draft** campaigns, add leads you supplied, pull analytics, draft replies
- **Must ask before:** activating Instantly campaigns, starting HeyReach campaigns, sending live replies, pausing/deleting production campaigns
- **Must not:** invent case studies or metrics, use real people in examples, put secrets in git, scrape LinkedIn with cookies, send HTML-with-links email 1 unless you opt in

---

## Repo map

```
AGENTS.md                 Bot standing orders
SETUP-PROMPT.md           First message to a new Grok Bot
company.example.md        Template for your ICP / offer / proof
playbooks/                Numbered motion (source of sequential truth)
.grok/skills/             Task skills (Grok Build loads these automatically)
examples/                 Fictional copy, leads JSON, company
scripts/check-setup.sh    Non-secret setup probe
```

Skills:

| Skill | Use when |
|-------|----------|
| [gtm-motion](.grok/skills/gtm-motion/SKILL.md) | Any outbound work — router |
| [grokbot-runtime](.grok/skills/grokbot-runtime/SKILL.md) | Installing/running CLIs on Grok Bot vs local-exec vs MCP |
| [deliverability](.grok/skills/deliverability/SKILL.md) | DNS, warmup, inbox placement, plain-text rules |
| [copywriting](.grok/skills/copywriting/SKILL.md) | Drafting or reviewing email / LinkedIn copy |
| [list-building](.grok/skills/list-building/SKILL.md) | Validating an ICP list before send |
| [data-sources](.grok/skills/data-sources/SKILL.md) | Prospeo, Ocean, LeadMagic, Clay, ZoomInfo `gtm` |
| [instantly-launch](.grok/skills/instantly-launch/SKILL.md) | Creating and launching Instantly campaigns |
| [heyreach-launch](.grok/skills/heyreach-launch/SKILL.md) | Creating and starting HeyReach campaigns |
| [replies](.grok/skills/replies/SKILL.md) | Classifying and drafting responses |
| [daily-ops](.grok/skills/daily-ops/SKILL.md) | Inbox, pause rules, scoreboard |

---

## Requirements

- Node.js 18+
- Grok Bot (SuperGrok Heavy / Cursor Ultra / Cursor Teams Premium) **or** Grok Build / any agent that can run shell commands
- Your own Instantly and/or HeyReach accounts

## License

MIT. See [LICENSE](LICENSE), [NOTICE.md](NOTICE.md), and [SECURITY.md](SECURITY.md).
