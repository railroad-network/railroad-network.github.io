# How decisions get made

Everything a community decides is a signed record in the same history as its
payments. There is no separate admin database and nothing an operator can
change by hand. This page is the plain-language version of the governance
design; the authoritative rules are in the decision records linked at the
bottom.

## The layers

**The Charter.** The founding document: principles, rights, founders. Changing
it is a formal amendment that chains to the version it replaces, so treaty
partners in a future federation can verify they are still dealing with the
same community. Amendments need a higher bar than ordinary rules.

**Statutes.** The community's ordinary laws, passed through the normal proposal
process. A statute cannot contradict the Charter.

**Precedent.** Jury rulings in disputes build up a record of how the rules are
read in practice.

## Who decides

The electorate is the **established members**: those whose computed standing
is high enough and whose identity is anchored by vouches. Standing is derived
from the history by one formula that no community can tune, so nobody can be
minted into the electorate by fiat.

### Bootstrap grace

A brand-new community has no established members. Rather than leave it unable
to govern, the software runs a **grace**: while fewer than three members are
established, the electorate is the founders plus whoever *is* established. The
app shows a banner while grace is on. It ends by itself the moment a third
member becomes established, and it never comes back.

## The life of a proposal

1. **Propose.** Any member authors a proposal: a title, a body, and a kind
   (an ordinary statute, a Charter amendment, or an emergency measure).
2. **Co-sign.** Other members endorse it. A proposal needs enough co-signers
   before it goes to a vote; this filters noise without letting anyone veto.
3. **Vote.** Established members cast ballots during a deliberation window,
   about a week for ordinary proposals.
4. **Tally and enact.** When the window closes, the station tallies the votes
   from the history. A passed statute is in force; a passed amendment becomes
   the new Charter.

Every step is a signed record. Anyone with the history can recompute the
result, and a station cannot fake a tally it did not derive.

## Which clock counts

Phones sign proposals and ballots with their own clocks, which may be wrong or
lying. The station therefore anchors every window on the **admission clock**:
the time the station admitted the record, not the time the author claimed. A
ballot that arrives after the window closed does not count, no matter what
time is written on it.

## What organizers should watch for

- **Quorum by attrition.** If members drift away, the electorate shrinks and a
  few people can pass anything. Keep vouching and trading so the established
  pool stays broad.
- **The emergency lever.** It exists to decide faster in a crisis and does
  nothing else, but it is the sharpest tool in the box. Read
  [Emergencies](emergencies.md) before you ever need it.
- **Charter creep.** If you find yourselves amending the Charter often, the
  content belongs in statutes.

## Where the rules are written down

- [ADR-0012](https://github.com/railroad-network/station/blob/main/docs/adr/0012-charter-format-and-amendments.md):
  the Charter and how it changes.
- [ADR-0015](https://github.com/railroad-network/station/blob/main/docs/adr/0015-electorate-bootstrap-grace.md):
  bootstrap grace.
- [ADR-0009](https://github.com/railroad-network/station/blob/main/docs/adr/0009-universal-reputation-algorithm.md):
  the one standing formula.
- [ADR-0022](https://github.com/railroad-network/station/blob/main/docs/adr/0022-admission-clock-time-trust.md):
  the admission clock.
