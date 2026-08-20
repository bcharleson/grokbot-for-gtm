# 01 — Company file

Goal: one source of truth for ICP, offer, and proof. The Bot must not invent these.

## Operator

```bash
cp company.example.md company.md
```

Fill every section. Write `unknown` rather than guessing. Proof is required before **launch** (playbooks 04–05). Draft campaigns can be built with a weaker proof section, but copy will omit metrics.

## Bot

1. Read `company.md`
2. Restate, in the operator's words:
   - who we email
   - the pain
   - the offer
   - the proof we are allowed to cite
   - which channels are on
3. Wait for "yes, that's us"
4. Flag empty proof, empty suppression, or a meeting-link CTA in email 1

## Pass / fail

- Fail if `company.md` is still the example template (look for blank fields after the colons)
- Fail if proof names a customer or number not in the file — ask, do not keep it

Next: [02-infrastructure.md](02-infrastructure.md)
