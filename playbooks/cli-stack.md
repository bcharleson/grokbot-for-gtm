# CLI stack

Packages this motion already knows how to call. Use whatever is **installed and authenticated** on the Bot computer. Do not install the whole table. Do not pitch a vendor the operator did not name.

Health-check before spend. JSON on stdout. Grok Bot: CLI binary, not stdio MCP. See [CONTRIBUTING.md](../CONTRIBUTING.md) to add another tool.

## Send

| Job | npm | bin | Health |
|-----|-----|-----|--------|
| Cold email | `instantly-cli` | `instantly` | `instantly campaigns list --limit 1` |
| Cold email | `emailbison-cli` | `bison` | `bison status` |
| Cold email | `@bcharleson/smartlead-cli` | `smartlead` | `smartlead --help` |
| LinkedIn (public API) | `heyreach-cli` | `heyreach` | `heyreach status` |

Default send path in playbooks 04–05 is Instantly + HeyReach. Bison / Smartlead only if `company.md` says so.

## List / enrich

Playbook: [03-data-sources.md](03-data-sources.md)

| Job | npm | bin | Health |
|-----|-----|-----|--------|
| ZoomInfo | `@zoominfo/gtm-ai-cli` | `gtm` | `gtm auth whoami` |
| Search + enrich | `prospeo-cli` | `prospeo` | `prospeo account info` |
| Search + enrich | `ocean-agent-cli` | `ocean` | `ocean credits balance` |
| Email find / validate | `leadmagic-agent-cli` | `leadmagic` | `leadmagic status` |
| Clay tables | `clay-gtm-cli` | `clay` | `clay tables list` |
| Prospecting | `seamless-ai-cli` | `seamless` | `seamless --help` |
| Signals | `trigify-cli` | `trigify` | `trigify --help` |
| Contact data | `contactout-agent-cli` | `contactout` | `contactout --help` |

## CRM (after interested)

When a reply is interested or a meeting is booked, write a **real record** in the CRM named in `company.md`. Do not invent amounts, stages, or contacts. Ask if the object/pipeline IDs are unknown.

| CRM | npm | bin | Auth | Health | After interested |
|-----|-----|-----|------|--------|------------------|
| HubSpot | `hubspot-cli` | `hubspot` | `HUBSPOT_ACCESS_TOKEN` | `hubspot status` | `hubspot contacts create` / `hubspot deals create` |
| Salesforce | `salesforce-crm-cli` | `salesforce` | `SALESFORCE_ACCESS_TOKEN` + `SALESFORCE_INSTANCE_URL` | `salesforce status` | `salesforce` lead/contact/opportunity commands; `salesforce limits get` |
| Attio | `attio-agent-cli` | `attio` | `ATTIO_API_KEY` | `attio status` | `attio people assert` / `attio companies assert` / `attio deals create` |
| Pipedrive | `pipedrive-agent-cli` | `pipedrive` | `PIPEDRIVE_API_TOKEN` | `pipedrive deals list --pretty` | `pipedrive deals create` |
| Close | `close-crm-cli` | `close` | token via `close login` | `close --help` | leads/opportunities per `--help` |
| Twenty | `twenty-agent-cli` | `twenty-agent` | instance URL + key | `twenty-agent --help` | any Twenty instance |

**Airtable** is not a CRM, but GTM teams keep pipeline here: npm `airtable-agent-cli`, bin `airtable`, env `AIRTABLE_TOKEN`, health `airtable bases list`. Upsert a row after interested:

```bash
airtable records upsert --base appXXX --table tblXXX \
  --merge-on "Email" \
  --fields '{"Name":"…","Email":"…","Status":"Interested"}'
```

Need base/table IDs from the operator. Do not guess them.

## Project management (ClickUp)

After interested / booked: a **task** the operator will see — not a silent CLI success.

npm `@bcharleson/clickup-cli`, bin `clickup`, env `CLICKUP_API_TOKEN` (`pk_…`), health `clickup status` or `clickup workspaces list --pretty`.

Hierarchy: workspace (team) → space → folder → list → task.

```bash
clickup workspaces list --pretty
clickup spaces list --team-id TEAM_ID
clickup tasks list --list-id LIST_ID --pretty
clickup tasks create --list-id LIST_ID --name "Follow up: {company} / {person}" --pretty
```

Ask for the list ID (or space) during intake. 105 commands / 19 groups if they need comments, time, goals — `--help`.

## Mail (Microsoft 365)

Instantly/HeyReach are the **outbound sequencers**. `ms365-cli` is the operator's **Outlook/work mailbox** (inbound that did not go through Instantly, calendar, OneDrive). Do not send cold sequences through Graph if Instantly is on.

npm `ms365-cli`, bin `m365`. Device login (Azure app): `M365_CLIENT_ID` + `M365_TENANT_ID`, then `m365 login`. Health: `m365 status --pretty`.

```bash
m365 mail unread-count
m365 mail list --pretty
m365 mail search "from:prospect@example.com"
m365 calendar list --start $(date -u +%Y-%m-%dT00:00:00Z) --pretty
```

Send/reply via Graph only if they asked and Instantly is not the path for that thread.

## Meetings

Links go in **replies**, not email 1. Use the scheduler in `company.md`. Default in this repo is **topcal**. Calendly and Cal.com are listed because operators already use them — if that is what `company.md` says, use that CLI and do not switch.

### topcal ([topcal.ai](https://topcal.ai))

**What it is.** Scheduling for humans *and* agents. A person shares a public booker link. An agent (you) can read open times and **finish the booking on the invitee's behalf** — slots → email OTP → confirm — without the invitee clicking a calendar grid and without you holding a host API key. That is the job this motion needs after a positive reply: get a meeting on the calendar, not dump a link and hope.

**Why it is in this stack.** Outbound dies at “here’s my Calendly.” The Bot is already in the thread. topcal lets that Bot complete the last mile (pick a slot with the human, confirm, return `joinUrl`) so the operator does not babysit a booking page. Host setup is device-auth CLI (`@topcal/cli`) — no pasted API key. Google or Microsoft calendar. Skill an agent can fetch: `https://topcal.ai/skill/SKILL.md`.

npm `@topcal/cli`, bin `topcal`, health `topcal auth status --json`.

**Guest** (invitee's agent). Booker: `https://topcal.ai/{workspace}/{username}/{eventSlug}`. No host key.

```
GET https://topcal.ai/api/v1/public/{workspace}/{username}/{eventSlug}/slots?timezone={invitee IANA}
GET .../otp?email={invitee email}&startAt={slot UTC}&timezone={IANA}&name={invitee name}
GET {confirmUrl}&code={digits the invitee reads from email}
```

Show 3–5 slots; do not pick unless they named a window. OTP to the **invitee's** email — never invent the code. Report `startAt` / `endAt` / `joinUrl`. Full loop: playbook 06. Public MCP: `https://topcal.ai/api/mcp/public/mcp`.

**Host** (operator's calendar):

```bash
npm i -g @topcal/cli
topcal auth register --wait auto
topcal calendars connect --provider google
topcal calendars status --json
```

Config: `~/.topcal/config.json` (0600). Then put the public booker URL in `company.md` as the reply CTA.

### If the operator already uses Calendly or Cal.com

Do not migrate them. Paste their URL in the reply, or the minimum CLI:

| | npm | bin | Health | Book |
|---|-----|-----|--------|------|
| Calendly | `calendly-cli` | `calendly` | `calendly users me` (`CALENDLY_TOKEN`) | `calendly invitees create` (Scheduling API; else paste URL) |
| Cal.com | `calcom-cli` | `calcom` | `calcom profile me` (`CAL_API_KEY`) | `calcom slots available` then `calcom bookings create` |

### Call notes / Zoom

| Job | npm | bin |
|-----|-----|-----|
| Fireflies | `fireflies-cli` | `fireflies` |
| Otter | `otter-agent-cli` | `otter` |
| Zoom | `zoom-agent-cli` | `zoom` |

## Other (only if that step is blocked)

| Job | npm | bin |
|-----|-----|-----|
| Inbox placement / blacklists | `emailguard-cli` | `emailguard` |
| Partner programs | `partnerstack-cli` | `partnerstack` |
| Workflow glue | `n8n-agent-cli` | `n8n-agent` |
| Slack | `slack-agent-cli` | `slack` |

Cookie-session LinkedIn CLIs are out of scope. ZoomInfo is `gtm`, not a `zoominfo` binary.
