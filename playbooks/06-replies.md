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

Do not argue. Do not add new claims. If they asked for a meeting and `company.md` has a calendar tool, share the link **in the reply**, not in the original sequence.

## Send

Live Instantly `email reply` and HeyReach `inbox send` need operator approval (see AGENTS.md).

After a booked meeting, optional CRM write is playbook 08. If no CRM is configured, append a line to a local `data/meetings.md` (gitignored) with date, person, company, source channel.

Next: [07-daily-ops.md](07-daily-ops.md)
