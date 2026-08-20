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

Links go in **replies**, not email 1. Use the tool named in `company.md`.

| Job | npm | bin | Notes |
|-----|-----|-----|--------|
| Booking link / host calendar | `@topcal/cli` | `topcal` | Device auth: `topcal auth status --json`. Public booker URLs are `https://topcal.ai/{workspace}/{username}/{eventSlug}` — slot JSON is unauthenticated GET (see playbook 06). Agent skill if needed: `https://topcal.ai/skill/SKILL.md` |
| Booking | `calendly-cli` | `calendly` | |
| Booking | `calcom-cli` | `calcom` | |
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
