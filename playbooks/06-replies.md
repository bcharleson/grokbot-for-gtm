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

Use **only** the scheduler in `company.md`. Default in this motion is topcal (agent can finish the booking in-thread). If they named Calendly or Cal.com, stay on that product.

### topcal (default)

[topcal.ai](https://topcal.ai) is agent-native scheduling: the operator shares a booker; **you** read times and complete the booking for the invitee so the meeting lands without anyone clicking a grid. That is the last mile after an interested reply.

Guest — public booker `https://topcal.ai/{workspace}/{username}/{eventSlug}`, no host key:

1. `GET .../slots?timezone={invitee IANA}`
2. Show 3–5 slots; ask which one.
3. OTP to the **invitee's** email: `GET .../otp?email=…&startAt=…&timezone=…&name=…` — use `confirmUrl`; never invent the code.
4. `GET {confirmUrl}&code={digits they read back}`
5. Log `startAt` / `endAt` / `joinUrl`.

If they only want a link, paste the booker URL. Host CLI: `topcal auth status --json`. Setup: `topcal auth register --wait auto` then `topcal calendars connect`. Skill: `https://topcal.ai/skill/SKILL.md`. Stack: [cli-stack.md](cli-stack.md).

### Calendly or Cal.com (if that is what they already use)

Paste the booking URL from `company.md`. Optional: `calendly users me` / `calcom profile me`. Do not run the topcal OTP flow on those products.

## Send

Live Instantly `email reply` and HeyReach `inbox send` need operator approval (see AGENTS.md).

After interested or a booked meeting, write the system of record named in `company.md` (see [cli-stack.md](cli-stack.md)):

- CRM: HubSpot / Salesforce / Attio / Pipedrive / Close / Twenty — create/assert the person + deal. No invented amounts.
- Airtable: upsert a row if that is their pipeline base.
- ClickUp: create a follow-up task on the list from intake.
- If none: append `data/meetings.md` (gitignored).

Next: [07-daily-ops.md](07-daily-ops.md)
