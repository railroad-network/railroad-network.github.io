# Glossary

**Admission clock.** The station's own clock at the moment it admits a record
to the log. Every time-bounded rule (settlement windows, voting windows,
dispute windows) is anchored on it, never on the time a phone wrote into the
record, because phones' clocks may be wrong or lying.

**Bootstrap grace.** The state of a community with fewer than three
established members. During grace the electorate and jury pool are the
founders plus whoever is established. Ends by itself and never returns.

**Bundle.** One or more members' signed records packaged for carriage to the
station over a route other than direct Wi-Fi: another phone, a radio, a text
message, or paper.

**Centicommon.** One hundredth of a Common. Every amount in the software is a
whole number of centicommons; there are no fractions or floats anywhere in a
signed record.

**Charter.** A community's founding document: its id, principles, guaranteed
rights, and founders, signed by the founders. Amendments chain to the version
they replace.

**Common.** The mutual-credit unit every community trades in. Created only by
one member paying another; the community's balances always sum to zero.

**Community.** The social entity: one station plus the members whose devices
pair with it. In protocol documents this word is preferred over "station" for
the entity, to keep it distinct from the software.

**Courier.** Anyone who physically carries records between a cut-off member
and the station. Needs no trust: every record is signed by its author and
re-checked by the station.

**Debt floor.** The lowest balance a member may sign themselves down to. The
default is 20 Commons in debt. Counts settled balance plus pending signed
debits.

**Dispute.** A signed record contesting a confirmed payment inside its
settlement window. Freezes settlement of that payment until a jury rules or
the dispute lapses.

**Emergency.** A supermajority-declared state that compresses the voting
window for emergency-kind proposals to 24 hours, freezes the Charter, pins the
electorate, and changes nothing else. Self-expiring.

**Equivocation.** Two conflicting records signed by the same member, such as
a headroom certificate spent twice offline. Provable from the log; costs the
member their entire standing and opens a jury case.

**Established member.** A member whose computed standing is at least 2.0 and
whose identity is anchored by vouches. The electorate and the jury pool.

**Fails open.** The property that every dispute and governance path, if
nobody acts in time, resolves to the confirmed status quo rather than
stalling. Nothing can be frozen forever by inaction.

**Federation.** Connection between communities: shared reputation, treaties,
cross-community trade. Planned for Phase 3; not built.

**Headroom certificate.** A station-signed reservation of part of a member's
credit headroom, requested while connected, so that a later offline payment
against it is accepted on arrival. Capped, time-limited, returnable.

**Log.** The hash-chained, signed, append-only record of everything that has
happened in a community. The single source of truth: balances, standing,
tallies, and every other view are derived from it by replay.

**Operator.** The person who runs the station computer.

**Organizer.** A founder or steward of a community. Not a software role.

**Outbox.** The queue of records a member has signed but which have not yet
been delivered to the station.

**Pairing.** The in-person ceremony by which a member's device and the
station establish that they are talking to each other, by comparing an
8-character code aloud. The security boundary of the transport.

**Proposal.** A signed motion to the electorate: an ordinary statute, a
Charter amendment, or an emergency measure. Co-signed, then voted on, then
tallied from the log.

**Receipt.** The station's signed answer to a delivered record, saying whether
it was admitted, was already known, or was refused and why.

**Replica.** An optional second station that pulls the writer's log for audit
or off-site backup. Admits nothing, so it can never fork the community. Not a
failover.

**Settlement window.** The delay between a payment being confirmed and the
balances moving: 24 hours for Tier 1, 48 hours for Tier 2. Doubles as the
window in which it can be contested.

**Shard.** One piece of a secret-shared key. A threshold of shards rebuilds
the key; fewer reveal nothing. Used for both member and station recovery.

**Sortition.** Selection by lot. Juries are three members drawn by a
standing-weighted, deterministic, log-derivable draw.

**Standing.** The reputation score computed for every member from the log by
one formula that no community can tune. Never stored authoritatively; every
copy is a cache.

**Station.** The software: the daemon that holds a community's wallet and
log, runs settlement, and serves the phones and the command-line client.
Also, loosely, the computer it runs on.

**Statute.** An ordinary community rule, passed by the normal proposal
process. May not contradict the Charter.

**Tier.** A payment's size class, which sets its settlement window and what
the confirmer must stake. Tier 1 and Tier 2 are served today; Tier 3 (50
Commons and up) is refused rather than shrunk.

**Vouch.** A signed attestation by one member that another member's key
belongs to a real, known person. Carries a stake; feeds standing and identity
anchoring.

**Writer.** The one station per community that owns and appends to the log.
