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

Links go in **replies**, not email 1. Use the scheduler in `company.md`.

### topcal — agent booking

npm `@topcal/cli`, bin `topcal`, health `topcal auth status --json`.

topcal is a scheduler built so **an agent can finish the booking**, not only paste a grid for a human to click.

Two jobs. Do not mix them.

**1. Guest (most common in this motion).** The operator's public booker is `https://topcal.ai/{workspace}/{username}/{eventSlug}` (stay on `topcal.ai`, do not rewrite to `app.topcal.ai`). You are the *invitee's* agent. No host API key.

```
GET https://topcal.ai/api/v1/public/{workspace}/{username}
GET https://topcal.ai/api/v1/public/{workspace}/{username}/{eventSlug}/slots?timezone={invitee IANA}
GET .../otp?email={invitee email}&startAt={slot UTC}&timezone={IANA}&name={invitee name}
GET {confirmUrl}&code={digits the invitee reads from email}
```

Show 3–5 slots; do not pick unless they named a window. OTP goes to the **invitee's** email — never invent the code. Report `booking.startAt`, `booking.endAt`, `booking.joinUrl` if present.

Public MCP (no auth): `https://topcal.ai/api/mcp/public/mcp`. Full procedure: playbook 06 and `https://topcal.ai/skill/SKILL.md`.

**2. Host.** Operator wants their own booker. Device auth, no pasted API key:

```bash
npm i -g @topcal/cli
topcal auth register --wait auto
topcal auth status --json
topcal calendars connect --provider google   # or microsoft
topcal calendars status --json
```

Credentials: `~/.topcal/config.json` (0600). Then share `https://topcal.ai/{workspace}/{username}/{eventSlug}` as the reply CTA.

### Other schedulers (CLI only)

| Job | npm | bin | Health |
|-----|-----|-----|--------|
| Calendly | `calendly-cli` | `calendly` | `calendly users me` (`CALENDLY_TOKEN`) |
| Cal.com | `calcom-cli` | `calcom` | `calcom profile me` (`CAL_API_KEY`) |
| Call notes | `fireflies-cli` | `fireflies` | |
| Call notes | `otter-agent-cli` | `otter` | |
| Meetings API | `zoom-agent-cli` | `zoom` | |

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
