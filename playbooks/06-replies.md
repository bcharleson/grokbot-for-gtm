# 06 — Replies and meetings

Goal: nothing interested sits unread. The Bot drafts; the operator sends until trust is earned.

Load `.grok/skills/replies/SKILL.md`.

## Pull

```bash
instantly email list --email-type reply --is-read false --output pretty
heyreach inbox list --seen false --pretty
```

## Classify every thread

| Label | Meaning | Next action |
|-------|---------|-------------|
| interested | Wants the asset or a meeting | Draft the promised send; offer times only if they asked |
| question | Needs a factual answer | Draft from `company.md` only |
| timing | Not now | Polite close + optional later |
| referral | Points to someone else | Ask for intro; do not email the other person uninvited |
| ooo | Auto-reply | Wait; do not burn a step arguing with a bot |
| unsubscribe / angry | Stop | Instantly: respect unsub. HeyReach: `campaigns stop-lead` |
| not-a-fit | Wrong ICP | Thank and stop |

Do not argue. Do not add new claims. If they asked for a meeting, put the **booking URL from `company.md`** in the reply — not in the original sequence.

Use **only** the scheduler in `company.md`. Do not switch products.

### If scheduler is topcal (agent booking)

This is the path where **you** can complete the meeting, not only dump a link.

Public booker: `https://topcal.ai/{workspace}/{username}/{eventSlug}` — keep that host; do not rewrite to `app.topcal.ai`.

1. Parse workspace / username / eventSlug from `company.md` booking URL.
2. Fetch open times (no auth):

```
GET https://topcal.ai/api/v1/public/{workspace}/{username}/{eventSlug}/slots?timezone={invitee IANA}
```

3. Show 3–5 slots in the invitee's timezone. Ask which one. Do not pick silently unless they already named a window.
4. Request OTP to the **invitee's** email (not the operator's):

```
GET https://topcal.ai/api/v1/public/{workspace}/{username}/{eventSlug}/otp?email={invitee email}&startAt={slot UTC}&timezone={IANA}&name={invitee name}
```

Use the returned `confirmUrl`. Tell them to read the 6-digit code from email. Never invent it.
5. `GET {confirmUrl}&code={digits they read back}`
6. Confirm `booking.startAt`, `booking.endAt`, and `booking.joinUrl` if present. Log it (CRM or `data/meetings.md`).

If they only want a link in the reply, paste the public booker URL and stop.

Host-side (operator's own calendar): `topcal auth status --json`. If not logged in and they asked you to *be* the host: `topcal auth register --wait auto` then `topcal calendars connect`. Detail: [cli-stack.md](cli-stack.md), `https://topcal.ai/skill/SKILL.md`.

### If scheduler is Calendly or Cal.com

Paste the booking URL from `company.md` in the reply. Optional CLI: `calendly users me` / `calcom profile me`. Do not run the topcal guest OTP flow on those products.

## Send

Live Instantly `email reply` and HeyReach `inbox send` need operator approval (see AGENTS.md).

After a booked meeting, optional CRM write is playbook 08. If no CRM is configured, append a line to a local `data/meetings.md` (gitignored) with date, person, company, source channel.

Next: [07-daily-ops.md](07-daily-ops.md)
