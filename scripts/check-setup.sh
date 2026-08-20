#!/usr/bin/env bash
# Probe local setup without printing secrets.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

ok=0
warn=0
fail=0

say() { printf '%s\n' "$1"; }
pass() { say "  ok    $1"; ok=$((ok + 1)); }
note() { say "  warn  $1"; warn=$((warn + 1)); }
miss() { say "  fail  $1"; fail=$((fail + 1)); }

present() {
  eval "v=\${$1-}"
  if [ -n "${v}" ]; then
    pass "$1 is set (${#v} chars, value hidden)"
  else
    miss "$1 is not set"
  fi
}

say "Grok Bot for GTM — setup check"
say "repo: $root"
say ""

say "Runtime"
if command -v node >/dev/null 2>&1; then
  pass "node $(node -v)"
else
  miss "node not on PATH (need 18+)"
fi

if command -v npm >/dev/null 2>&1; then
  pass "npm $(npm -v)"
else
  miss "npm not on PATH"
fi

say ""
say "CLIs"
if command -v instantly >/dev/null 2>&1; then
  pass "instantly -> $(command -v instantly)"
elif [ -x "$root/node_modules/.bin/instantly" ]; then
  pass "instantly -> $root/node_modules/.bin/instantly (local)"
else
  note "instantly not installed (npm i -g instantly-cli) — required for email path"
fi

if command -v heyreach >/dev/null 2>&1; then
  pass "heyreach -> $(command -v heyreach)"
elif [ -x "$root/node_modules/.bin/heyreach" ]; then
  pass "heyreach -> $root/node_modules/.bin/heyreach (local)"
else
  note "heyreach not installed (npm i -g heyreach-cli) — required for LinkedIn path"
fi

probe_cli() {
  local bin="$1" pkg="$2"
  if command -v "$bin" >/dev/null 2>&1; then
    pass "$bin -> $(command -v "$bin")"
  else
    note "$bin not installed (optional — npm i -g $pkg)"
  fi
}

say ""
say "List / enrich CLIs (optional)"
probe_cli gtm "@zoominfo/gtm-ai-cli"
probe_cli prospeo prospeo-cli
probe_cli ocean ocean-agent-cli
probe_cli leadmagic leadmagic-agent-cli
probe_cli clay clay-gtm-cli
if command -v cloudflared >/dev/null 2>&1; then
  pass "cloudflared -> $(command -v cloudflared) (Clay --wait callbacks)"
fi

say ""
say "Meetings / CRM (optional)"
probe_cli calendly calendly-cli
probe_cli calcom calcom-cli
probe_cli topcal "@topcal/cli"
probe_cli hubspot hubspot-cli
probe_cli attio attio-agent-cli
probe_cli bison emailbison-cli
probe_cli smartlead "@bcharleson/smartlead-cli"

say ""
say "Files"
if [ -f "$root/company.md" ]; then
  pass "company.md exists"
else
  miss "company.md missing — copy company.example.md and fill it"
fi

if [ -f "$root/.env" ]; then
  pass ".env exists (not reading values)"
  # Load for presence checks only
  set -a
  # shellcheck disable=SC1091
  . "$root/.env"
  set +a
else
  note ".env missing — copy .env.example (optional if you export keys another way)"
fi

say ""
say "Env (presence only)"
if [ -n "${INSTANTLY_API_KEY-}" ]; then
  present INSTANTLY_API_KEY
else
  note "INSTANTLY_API_KEY unset — email path unavailable"
fi
if [ -n "${HEYREACH_API_KEY-}" ]; then
  present HEYREACH_API_KEY
else
  note "HEYREACH_API_KEY unset — LinkedIn path unavailable"
fi

for optional in PROSPEO_API_KEY LEADMAGIC_API_KEY OCEAN_API_TOKEN APOLLO_API_KEY HUBSPOT_ACCESS_TOKEN ATTIO_API_KEY CALENDLY_TOKEN CAL_API_KEY CALENDLY_API_KEY CALCOM_API_KEY; do
  eval "v=\${$optional-}"
  if [ -n "${v}" ]; then
    pass "$optional is set (optional)"
  fi
done
if command -v gtm >/dev/null 2>&1; then
  note "ZoomInfo uses gtm auth login (OAuth), not an env API key — run gtm auth whoami"
fi

say ""
say "Summary: $ok ok, $warn warn, $fail fail"
if [ "$fail" -gt 0 ]; then
  say "Fix fail items before asking the Bot to launch."
  exit 1
fi
if [ -z "${INSTANTLY_API_KEY-}" ] && [ -z "${HEYREACH_API_KEY-}" ]; then
  say "No channel keys set. Fill INSTANTLY_API_KEY and/or HEYREACH_API_KEY."
  exit 1
fi
exit 0
