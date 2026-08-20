# 08 — Optional stack

Not required for the first motion. Add one tool when a playbook 00–07 step is clearly blocked without it.

All of these have agent-native CLIs from the same family as Instantly/HeyReach. Install only what you have keys for. Documented here so Grok Bot knows the names — not so it installs everything.

List/enrich CLIs live in [03-data-sources.md](03-data-sources.md) (ZoomInfo `gtm`, Prospeo, Ocean, LeadMagic, Clay). This page is everything else.

| Gap | Tool | CLI | Notes |
|-----|------|-----|-------|
| People search (extra) | Apollo, Seamless | `apollo-agent-cli`, `seamless-ai-cli` | Do not scrape LinkedIn |
| CRM | HubSpot, Attio, Pipedrive | `hubspot-cli`, `attio-agent-cli`, `pipedrive-agent-cli` | Write deals only after interested |
| Booking | Calendly, Cal.com | `calendly-cli`, `calcom-cli` | Link in **replies**, not email 1 |
| Notes after the call | Fireflies, Otter | `fireflies-cli`, `otter-cli` | |
| Glue / webhooks | n8n | `n8n-agent-cli` | For durable automations outside the Bot |

Rules if you add them:

- Same secret policy: env vars, never chat
- Same proof policy: no invented CRM data
- Grok Bot: install the CLI on the Bot computer; do not attach stdio MCP

First motion = Instantly and/or HeyReach only.
