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

If that URL is `https://topcal.ai/{workspace}/{username}/{eventSlug}` and they want times in-thread:

```
GET https://topcal.ai/api/v1/public/{workspace}/{username}/{eventSlug}/slots?timezone={invitee IANA}
```

Show 3–5 slots; do not pick one. Guest confirm is email OTP on the invitee's address — do not invent the code. Host-side CLI (only if `topcal` is installed and they asked to manage the calendar): `topcal auth status --json`. Command detail: [cli-stack.md](cli-stack.md) and `https://topcal.ai/skill/SKILL.md`.

Same rule for Calendly / Cal.com: use whatever `company.md` named. Do not switch booking products.

## Send

Live Instantly `email reply` and HeyReach `inbox send` need operator approval (see AGENTS.md).

After a booked meeting, optional CRM write is playbook 08. If no CRM is configured, append a line to a local `data/meetings.md` (gitignored) with date, person, company, source channel.

Next: [07-daily-ops.md](07-daily-ops.md)
