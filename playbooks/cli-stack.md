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

| Job | npm | bin |
|-----|-----|-----|
| HubSpot | `hubspot-cli` | `hubspot` |
| Attio | `attio-agent-cli` | `attio` |
| Pipedrive | `pipedrive-agent-cli` | `pipedrive` |
| Salesforce | `salesforce-crm-cli` | `salesforce` |
| Close | `close-crm-cli` | `close` |
| Twenty | `twenty-agent-cli` | `twenty-agent` |

## Meetings

Links go in **replies**, not email 1. Use the scheduler in `company.md`. All three booking CLIs below are published and cover list-types → slots → book. Same job; different auth.

### Calendly (`calendly-cli`)

Published `1.0.5`, bin `calendly`. Env `CALENDLY_TOKEN` (or `calendly login`). Health: `calendly users me`.

Agent loop:

```bash
calendly users me --pretty
calendly event-types list --pretty
calendly availability event-times \
  --event-type https://api.calendly.com/event_types/EVENT_UUID \
  --start-time 2026-03-20T00:00:00Z \
  --end-time 2026-03-27T00:00:00Z
# range max 7 days
calendly invitees create \
  --event-type https://api.calendly.com/event_types/EVENT_UUID \
  --start-time 2026-03-21T14:00:00Z \
  --name "Jane Smith" \
  --email jane@example.com
calendly scheduled-events list --status active --pretty
```

`invitees create` is Calendly's Scheduling API (paid plan). If you cannot book via API, paste the event-type scheduling URL in the reply. Also: `calendly availability busy-times`, `calendly scheduling-links create`.

### Cal.com (`calcom-cli`)

Published `0.1.0`, bin `calcom`. Env `CAL_API_KEY`. Health: `calcom profile me`. Local folder is `~/Developer/cal-cli`; npm/GitHub name is `calcom-cli`.

Agent loop:

```bash
calcom profile me --pretty
calcom event-types list --pretty
calcom slots available \
  --event-type-id 123 \
  --start-time 2026-03-20T00:00:00Z \
  --end-time 2026-03-27T00:00:00Z \
  --timezone America/New_York --pretty
calcom bookings create \
  --event-type-id 123 \
  --start 2026-03-21T14:00:00Z \
  --attendee-name "Jane Smith" \
  --attendee-email jane@example.com \
  --attendee-timezone America/New_York
calcom bookings list --status upcoming --pretty
```

Also: `calcom bookings cancel|reschedule`, `calcom schedules list`.

### topcal (`@topcal/cli`)

Published `0.1.1`, bin `topcal`. Device auth (no env key by default). Health: `topcal auth status --json`.

**Guest** — you book on the *invitee's* behalf against a public booker `https://topcal.ai/{workspace}/{username}/{eventSlug}`. No host API key.

```
GET https://topcal.ai/api/v1/public/{workspace}/{username}/{eventSlug}/slots?timezone={invitee IANA}
GET .../otp?email={invitee email}&startAt={slot UTC}&timezone={IANA}&name={invitee name}
GET {confirmUrl}&code={digits the invitee reads from email}
```

Show 3–5 slots; do not pick unless they named a window. OTP goes to the invitee's email — never invent the code. Report `booking.startAt`, `endAt`, `joinUrl` if present. Procedure: playbook 06. Skill: `https://topcal.ai/skill/SKILL.md`.

**Host** — operator's own booker:

```bash
npm i -g @topcal/cli
topcal auth register --wait auto
topcal calendars connect --provider google
topcal calendars status --json
```

Config: `~/.topcal/config.json` (0600). Then share the public booker URL in replies.

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
| Tasks | `@bcharleson/clickup-cli` | `clickup` |
| Mail / calendar (M365) | `ms365-cli` | `m365` |
| Tables | `airtable-agent-cli` | `airtable` |

Cookie-session LinkedIn CLIs are out of scope. ZoomInfo is `gtm`, not a `zoominfo` binary.
