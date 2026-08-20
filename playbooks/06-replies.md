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

Use **only** the scheduler in `company.md`. Do not switch products. All three CLIs can list types, fetch slots, and book. Show 3–5 times; ask; then book. If API book is not allowed, paste the URL from `company.md`.

### Calendly

```bash
calendly users me --pretty
calendly event-types list --pretty
calendly availability event-times --event-type EVENT_URI --start-time ISO --end-time ISO
# event-times range max 7 days
calendly invitees create --event-type EVENT_URI --start-time ISO --name "…" --email invitee@…
```

`invitees create` needs Calendly Scheduling API (paid). Fallback: their scheduling URL in the reply.

### Cal.com

```bash
calcom profile me --pretty
calcom event-types list --pretty
calcom slots available --event-type-id ID --start-time ISO --end-time ISO --timezone IANA --pretty
calcom bookings create --event-type-id ID --start ISO \
  --attendee-name "…" --attendee-email invitee@… --attendee-timezone IANA
```

### topcal

Guest (invitee's agent, public booker, no host key):

1. Booking URL shape: `https://topcal.ai/{workspace}/{username}/{eventSlug}`
2. `GET https://topcal.ai/api/v1/public/{workspace}/{username}/{eventSlug}/slots?timezone={invitee IANA}`
3. Ask which slot.
4. OTP to the **invitee's** email: `GET .../otp?email=…&startAt=…&timezone=…&name=…` — use `confirmUrl`; never invent the code.
5. `GET {confirmUrl}&code={digits they read back}`
6. Log `startAt` / `endAt` / `joinUrl`.

Host (operator's calendar): `topcal auth status --json`. Setup: `topcal auth register --wait auto` then `topcal calendars connect`. Skill: `https://topcal.ai/skill/SKILL.md`.

Bins, env, extra commands: [cli-stack.md](cli-stack.md).

## Send

Live Instantly `email reply` and HeyReach `inbox send` need operator approval (see AGENTS.md).

After a booked meeting, optional CRM write is playbook 08. If no CRM is configured, append a line to a local `data/meetings.md` (gitignored) with date, person, company, source channel.

Next: [07-daily-ops.md](07-daily-ops.md)
