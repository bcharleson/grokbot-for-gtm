# 00 — Intake

Goal: the operator answers; you write `company.md`. Do not invent ICP, proof, tools, or metrics. Do not skip a question because you "already know."

Load `.grok/skills/intake/SKILL.md`.

If `company.md` is missing, copy `company.example.md` → `company.md` first, then fill it from this interview.

## How to ask

- One **batch** at a time. Wait for answers before the next batch.
- Multiple choice when the playbooks already have a closed set (channel, data source, calendar, CRM).
- If they say "skip" / "none" / "unknown", write that in `company.md`. Do not substitute a guess.
- After all batches: rewrite `company.md`, read it back in 8–10 bullets, wait for **"yes, that's us"** before playbook 00-prerequisites health checks that spend anything.

## Batch 1 — Who you are

1. Company name and website?
2. One sentence: what do you sell?
3. Sender name, role, and From-name on email?
4. Timezone for send windows?

## Batch 2 — Who you email

5. Job titles?
6. Seniority and department?
7. Company type / industry and employee range?
8. Geography?
9. Who must we **never** email (titles, industries, competitor domains, current customers)?

## Batch 3 — Pain, offer, proof

10. What pain do they already feel (observable, not your feature list)?
11. What do you actually sell, and what is a first conversation *for*?
12. After a "yes", what asset can we send (no link in email 1)?
13. Proof we are allowed to cite (customer + outcome you will stand behind, or "none — write copy without a metric")?
14. Preferred first CTA (low-friction default: "mind if I send X?")?

## Batch 4 — Channels and keys

Ask what they use. Then run `npm run check` and only enable what authenticated.

15. Email via Instantly — yes/no? (needs `INSTANTLY_API_KEY`)
16. LinkedIn via HeyReach — yes/no? (needs `HEYREACH_API_KEY`)
17. Sending domain(s) for cold email?
18. Daily cap per inbox? LinkedIn connection cap?
19. EmailBison or Smartlead instead of Instantly? Only if they named it.

## Batch 5 — List

20. Do you already have a list file, or should we pull from a data CLI?
21. If a CLI: which one is installed — `gtm` (ZoomInfo), Prospeo, Ocean, LeadMagic, Clay, Seamless, Trigify, ContactOut, or a file in `lists/`?
22. Max people in the first batch (default 50)?
23. Spend credits to enrich emails — yes/no?

## Batch 6 — Meetings (replies only)

Do not put a booking link in email 1 unless they explicitly opt in.

24. When someone wants a meeting, which scheduler? The Bot can list slots and book on all three.
    - Calendly — `calendly-cli`, `CALENDLY_TOKEN`, `calendly users me`
    - Cal.com — `calcom-cli`, `CAL_API_KEY`, `calcom profile me`
    - topcal — `@topcal/cli`, `topcal auth status --json`; guest booker `https://topcal.ai/{workspace}/{username}/{eventSlug}`
    - none / paste some other URL
25. Paste the **booking URL** for replies (or "I'll share after they say yes").
26. Confirm the matching CLI health check. Do not switch products.

## Batch 7 — CRM, voice, suppression

27. CRM: none | HubSpot | Attio | Pipedrive | Salesforce | Close | Twenty | other?
28. What does "interested" mean for a CRM record, and who owns new deals?
29. Extra suppression list location?
30. Words we use / never use? Formality: casual / plain / formal?

## After the interview

1. Write every answer into `company.md` (gitignored).
2. Summarize. Wait for confirmation.
3. Continue to [00-prerequisites.md](00-prerequisites.md) (CLI health) then 02+.
