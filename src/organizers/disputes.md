# Disputes

A payment can be contested while it is confirmed but not yet settled. This
page explains what happens next, so organizers can explain it to members and
then stay out of the way. The jury is designed to work without anyone
running it.

## Raising a dispute

Either party to a confirmed payment can contest it during its settlement
window, from the app or the command line. Contesting **freezes settlement** of
that one payment; nothing else is affected. The disputer writes a short
reason and may attach a fingerprint of evidence held elsewhere.

The other party may file a response. Neither is required to.

## The jury

The software draws **three jurors** by lot from the established members,
weighted by standing, excluding the parties. The draw is deterministic from
the history, so anyone can verify that the panel is the one the rules produce
and not one somebody picked.

Jurors are notified in the app. Each casts a verdict: uphold the dispute (the
payment is voided) or reject it (the payment stands). **Majority rules.**

## Every path fails open

There is a bounded window for the jury to rule. If it closes without a
majority, the dispute **lapses and the confirmed payment stands**. Nobody can
stall a payment forever by contesting it, and nobody can block a ruling by
refusing to serve. The default outcome is always the status quo.

## What an upheld dispute does

- The pending transfer is voided. Balances do not move.
- The member who **confirmed** the payment takes a hit to their standing. This
  is the point of the settlement window and the reason confirming is a
  serious act: it is where the "we both say this trade happened" claim gets
  tested.

## Escalation and appeal

Two paths lead from the jury to the whole electorate, both optional:

- **Escalation**, when a panel cannot be seated (too few eligible members, for
  instance). A party asks the electorate to decide directly.
- **Appeal**, when a party disagrees with the jury's ruling. It suspends
  enactment of the ruling while the electorate votes.

Both use the same bounded windows and fail open the same way.

## Equivocation cases

One kind of case is opened by the station rather than a member: **provable
equivocation**, when two conflicting records signed by the same member reach
the station, for instance a headroom certificate spent twice offline. The
member's standing drops to nothing immediately, and a jury case opens with the
evidence attached. These cases default to lapsing if the jury does not act,
like every other.

## What organizers should do

- **Explain the window.** Most bad outcomes are a member who noticed a problem
  after settlement, when it was final.
- **Do not lobby jurors.** The whole design is that the panel is random and
  the reasoning is theirs.
- **Read the rulings.** Precedent is how a community learns what its own rules
  mean.

The authoritative rules are [ADR-0014](https://github.com/railroad-network/station/blob/main/docs/adr/0014-phase-1-dispute-resolution.md)
and [ADR-0025](https://github.com/railroad-network/station/blob/main/docs/adr/0025-equivocation-dispute-cases.md).
