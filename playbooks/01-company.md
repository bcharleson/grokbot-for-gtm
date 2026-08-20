# 01 — Company file

Goal: `company.md` is complete from **intake**, not from the Bot guessing.

The interview is [00-intake.md](00-intake.md). This page is only the pass/fail on the file.

## Operator

You can still `cp company.example.md company.md` and type. Prefer letting the Bot ask the batches in 00-intake.

## Bot

If any required field is blank, return to intake. Then:

1. Read `company.md`
2. Restate ICP, pain, offer, proof, channels, list source, scheduler
3. Wait for "yes, that's us"
4. Flag empty proof, empty suppression, or a meeting link planned for email 1

## Pass / fail

- Fail if `company.md` is still the example template (look for blank fields after the colons)
- Fail if proof names a customer or number not in the file — ask, do not keep it

Next: [02-infrastructure.md](02-infrastructure.md)
