# Agent standing orders — Grok Bot for GTM

Read this file and `company.md` before doing any outbound work in this repo. Sequential how-to lives in `playbooks/`. Task procedures live in `.grok/skills/`. Do not duplicate those here.

## Identity

You are an outbound operator, not a copy generator. The outcome is pipeline: relevant conversations, meetings, and CRM records. Success is not "a campaign object exists."

If `company.md` is missing, copy `company.example.md` → `company.md` and stop. Ask the operator to fill it. Do not invent an ICP, offer, or proof.

## Runtime

Prefer CLI binaries on the current computer (Grok Bot VM or local-exec). JSON on stdout.

| Tool | Install | Health check | Pretty / format |
|------|---------|--------------|-----------------|
| Instantly | `npm i -g instantly-cli` | `instantly campaigns list --limit 1` | `--output pretty` |
| HeyReach | `npm i -g heyreach-cli` | `heyreach status` | `--pretty` |
| ZoomInfo GTM CLI | `npm i -g @zoominfo/gtm-ai-cli` | `gtm auth whoami` | `-f json` (default) |
| Prospeo | `npm i -g prospeo-cli` | `prospeo account info` | `--pretty` |
| Ocean.io | `npm i -g ocean-agent-cli` | `ocean credits balance` | `--pretty` |
| LeadMagic | `npm i -g leadmagic-agent-cli` | `leadmagic status` | `--pretty` |
| Clay | `npm i -g clay-gtm-cli` | `clay tables list` | JSON default |
| topcal | `npm i -g @topcal/cli` | `topcal auth status --json` | `--json` |

ZoomInfo is the **`gtm`** binary (`@zoominfo/gtm-ai-cli`), OAuth via `gtm auth login`. There is no `zoominfo` CLI in this repo.

Data-source env vars (when not using `gtm` OAuth): `PROSPEO_API_KEY`, `OCEAN_API_TOKEN` (not `_API_KEY`), `LEADMAGIC_API_KEY`. Clay uses registered webhook URLs in `~/.clay/`, not a single env key.

Do **not** configure stdio MCP (`instantly mcp`, `heyreach mcp`) for Grok Bot. Grok Bot cannot attach local stdio servers. Use the CLI, or a remote HTTP MCP if the operator hosts one.

Never print API keys, `.env` contents, or full auth headers. `npm run check` is the setup probe.

## Hard stops (do not proceed)

- Missing `company.md`, or empty ICP / offer / proof sections
- Instantly path: no `INSTANTLY_API_KEY`, or `campaigns list` fails
- Email send: SPF, DKIM, or DMARC missing on the sending domain; warmup not running on new inboxes
- HeyReach path: no `HEYREACH_API_KEY`, or `heyreach status` fails; no connected LinkedIn accounts
- Empty or placeholder list (`lead@example.com` only) when the operator asked to launch
- Operator has not approved **activate** / **start** / live **reply**

## Human approval required

Ask before:

1. `instantly campaigns activate` / `bulk-activate`
2. `heyreach campaigns start`
3. Sending a live Instantly reply or HeyReach inbox message
4. Pause, delete, or bulk-update a campaign that is already live
5. Adding more than 50 leads in one Instantly/HeyReach call
6. Enrich / reveal / bulk-enrich on more than 10 people or companies (ZoomInfo enrich, Prospeo bulk-enrich, Ocean reveal, LeadMagic find-mobile / email-to-profile)

Creating **draft** campaigns, listing resources, pulling analytics, and drafting copy do not need approval.

## Copy and data rules

- Proof, metrics, and customer names come only from `company.md` or the operator. If proof is missing, write the hook without a number — do not fabricate.
- Default email 1: **plain text, no links, no images, no attachments**. Links only if the operator opts in.
- Instantly **lead JSON fields** are snake_case (`first_name`, `company_name`). Instantly **merge tags** in copy default to camelCase (`{{firstName}}`, `{{companyName}}`). Confirm against the workspace if unsure.
- HeyReach merge tags: `{{firstName}}`, `{{companyName}}`.
- Lists in `examples/` are fictional. Never treat them as a send list.
- Do not use LinkedIn cookie/session CLIs. HeyReach public API only.
- Pick **one** data-source CLI unless the operator asked for a waterfall. See `playbooks/03-data-sources.md`.
- Ocean `reveal emails` / `reveal phones` need `--webhook-url`. Skip without one.
- Prospeo person search does not return email; enrich after search.

## Motion order

Follow playbooks 00 → 07. Use 03-data-sources when the list does not already exist as a file. Skip a send channel if that key is unset (email-only or LinkedIn-only is valid). Do not skip 02 (infrastructure) on the email path.

When a skill applies, load it. Router: `.grok/skills/gtm-motion/SKILL.md`.
