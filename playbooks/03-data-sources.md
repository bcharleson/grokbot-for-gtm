# 03b — Data sources

Goal: pick **one** CLI the operator actually has, build 25–50 ICP people, write `lists/` (gitignored). Do not run every provider.

Load `.grok/skills/data-sources/SKILL.md`. Then map into [03-list.md](03-list.md) Instantly / HeyReach shapes.

## Pick one

Use `company.md` → Data sources. If unset, take the first that passes a health check. Do not waterfall four paid APIs on the same row unless the operator asked.

| Preference | CLI | Install | Health | Best at | Cost note |
|------------|-----|---------|--------|---------|-----------|
| `gtm` | `gtm` ([GTM CLI](https://gtm.ai/docs/cli) / ZoomInfo) | `npm i -g @zoominfo/gtm-ai-cli` or `brew install zoominfo/gtm-ai/gtm-ai-cli` | `gtm auth whoami` | Verified companies/contacts, intent, scoops | Search/lookup **free**. Enrich + research **consume ZoomInfo bulk credits** |
| `prospeo` | `prospeo` | `npm i -g prospeo-cli` | `prospeo account info` | Person/company search + enrich (sync) | Search is 1 credit/page. Enrich 1 (10 with mobile). Search **does not** return email — enrich after |
| `ocean` | `ocean` | `npm i -g ocean-agent-cli` | `ocean credits balance --pretty` | People/company search, lookalikes | Sync enrich is fine. `reveal emails/phones` is **async and needs `--webhook-url`** — skip reveal unless a webhook exists |
| `leadmagic` | `leadmagic` | `npm i -g leadmagic-agent-cli` | `leadmagic status` | Email find/validate, role at company, job-change | Pay-for-found except `people job-change` (always 3 credits) |
| `clay` | `clay` | `npm i -g clay-gtm-cli` + `cloudflared` | `clay tables list` and `clay listen status` | Waterfall the operator already built in Clay | Not a data API. Fires **your** Clay webhook tables. `--wait` needs a reachable callback |
| `file` | — | — | `lists/*.json` exists | Operator-exported CSV/JSON | No API |

There is **no** `zoominfo` / `zoominfo-cli` binary in this motion. ZoomInfo is the `gtm` command from `@zoominfo/gtm-ai-cli`. Brandon's unpublished `zoominfo-cli-INWORK` folder is not a product — do not invent commands for it.

## GTM CLI (`gtm`) — ZoomInfo

Docs: [gtm.ai/docs/cli](https://gtm.ai/docs/cli) · source: [Zoominfo/gtm-ai-cli](https://github.com/Zoominfo/gtm-ai-cli)

Auth is **browser OAuth**, not an env API key:

```bash
gtm auth login     # opens browser; token → ~/.config/gtm-ai/ (mode 0600)
gtm auth whoami
```

On Grok Bot, run `gtm auth login` on the **Bot computer** so the Bot's browser completes OAuth. Local-exec uses the operator's Mac login instead.

**Lookup first.** Search 422s on unknown industry/metro/topic strings.

```bash
gtm lookup --field industries --fuzzy software -f table
gtm lookup --field management-levels -f table
gtm lookup --field metro-regions --fuzzy "san francisco"
```

Search (free):

```bash
gtm companies search --industry software --employees "51to100,101to250" --country "United States" --page-size 25 -f json
gtm contacts search --management-level "VP Level Exec,Director" --department Operations \
  --required email --page-size 25 -f json
```

Enrich (credits). Ask before bulk:

```bash
gtm contacts enrich --email alex@example.com --fields email firstName lastName jobTitle
gtm companies enrich --domain example.com --fields name website employeeCount
```

Default output is JSON:API (`.data[].id`, `.data[].attributes`). Use `-f jsonl` or `-f csv` when flattening. `--select` projects fields client-side; enrich `--fields` is server-side.

Intent / scoops (optional, after a list exists):

```bash
gtm lookup --field intent-topics --fuzzy "field service"
gtm intent search --topics "Exact Topic From Lookup" --signal-score-min 70
```

## Prospeo

```bash
export PROSPEO_API_KEY=...
prospeo account info --pretty

# Exact strings required for filters
prospeo suggestions job-title --query "vp operations"
prospeo suggestions location --query "united states"

prospeo person search --filters '{
  "person_job_title": {"include": ["VP of Operations"]},
  "person_location_search": {"include": ["United States"]},
  "company_headcount_range": ["51-100","101-200"]
}' --page 1 --pretty

# Search has no email. Then:
prospeo person bulk-enrich --data '[{"identifier":"1","linkedin_url":"..."}]' --only-verified-email --pretty
```

`linkedin_url` is the strongest person id. `company_website` (hostname, not a marketing sentence) is the strongest company id. Max 50 per bulk-enrich.

## Ocean.io

Env is **`OCEAN_API_TOKEN`**, not `OCEAN_API_KEY`.

```bash
export OCEAN_API_TOKEN=...
ocean credits balance --pretty
ocean data-fields list
ocean autocomplete job-titles --query "vp operations"

ocean search people \
  --people-filters '{"jobTitleKeywords":{"anyOf":["VP Operations"]},"countries":["us"]}' \
  --limit 25 --pretty

ocean enrich person --linkedin "https://linkedin.com/in/example" --pretty
ocean enrich company --domain example.com --pretty
```

`jobTitleKeywords` must be `{"anyOf":[...]}` — not a plain array. Domains are hostnames (`example.com`), not `https://` URLs.

Do **not** call `ocean reveal emails` unless the operator has a public `--webhook-url`. Grok Bot has no default webhook.

## LeadMagic

```bash
export LEADMAGIC_API_KEY=...
leadmagic status --pretty
leadmagic credits

# Cheap first
leadmagic people validate-email --email alex@example.com --pretty
leadmagic people find-email --first-name Alex --last-name Rivera --domain example.com --pretty
leadmagic people find-role --job-title "VP of Operations" --company-domain example.com --pretty
leadmagic people profile-to-email --profile-url "https://linkedin.com/in/example" --pretty

# Company context
leadmagic companies search --domain example.com --pretty
```

Credit order for a person: validate-email (0.25) → find-email (1) → profile-to-email (5). `people job-change` always bills 3. `people find-mobile` is 5 — only if the operator asked for mobile.

## Clay (`clay-gtm-cli`)

Clay is **your tables**, not a people database. The CLI POSTs to webhook URLs you registered.

```bash
clay tables add --name enrich-lead --webhook-url https://app.clay.com/webhook/YOUR_ID
clay listen start          # needs cloudflared; prints a public callback URL
clay fire enrich-lead --data '{"linkedin_url":"https://linkedin.com/in/example"}' --wait --timeout 180
```

`--wait` injects `_callback_url` / `_callback_id`. The Clay table's last step must HTTP POST to that callback. On Grok Bot, either run `clay listen start` on the Bot computer or `clay config set --callback-url https://your-stable-https-endpoint`.

If no tables are registered, Clay is not available — pick another source.

## After you have rows

Write `lists/icp-batch-1.json` (Instantly snake_case) and/or `lists/icp-batch-1-linkedin.json` (HeyReach camelCase). Validate with playbook 03. First batch **25–50**.

Ask before any enrich/reveal/bulk that will spend credits on more than 10 records.
