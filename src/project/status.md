# Status and roadmap

*Last updated 2026-09-17.*

Railroad Network is built in phases, each meant to be useful on its own.

| Phase | Scope | State |
| --- | --- | --- |
| 0 | Crypto core, signed log, identity, ledger, daemon and CLI | Done |
| 1 | Mobile app, vouching, standing, marketplace, oracle tiers 1 and 2, governance, disputes, pilot readiness | Done; the 90-day community pilot has not yet been run |
| 2 | Single-community resilience: offline-first, delay-tolerant sync, headroom certificates, paper, LoRa radio, SMS codec, emergency governance, encrypted at rest | Done, closed 2026-09-13 |
| 3 | Federation between communities | Not started |

> **Phase numbering.** Documents written before 2026-08-25 call federation
> "Phase 2". A decision record (ADR-0017) moved single-community resilience
> ahead of federation, so resilience became Phase 2 and federation Phase 3.
> Older decision records keep the old numbering as written.

## What works today

- One community: one station and the phones and laptops that pair with it.
- Payments with settlement windows and a debt floor. Tiers 1 and 2.
- Vouching, computed standing, established members, bootstrap grace.
- A marketplace: listings, needs, inquiries, recurring contracts.
- Charter founding ceremony, proposals, co-signing, voting, statutes.
- Jury disputes by sortition, escalation, appeal, equivocation cases.
- Emergency governance with a supermajority declaration and hard expiry.
- Offline signing with an outbox; delivery by another phone, paper, or LoRa
  radio; signed receipts; headroom certificates.
- Encrypted station backups, station key recovery held by members, and an
  optional encrypted at-rest profile unlocked by a member quorum.
- A self-custody command-line wallet for members without a phone.

## What does not work yet

- **No federation.** Communities cannot see or trade with each other.
- **No Tier 3 or higher.** Payments of 50 Commons and up are refused.
- **No SMS gateway.** The codec is built and tested; the physical modem side
  is not.
- **No app store, no iOS.** Android, sideloaded.
- **No independent audit.** See [Security and audits](security.md).

## The pilot

What remains of Phase 1 is running the real thing: a 90-day pilot with a
community of around twenty people, play stakes, one station. The runbooks
were written for it. If you run one, the project wants to hear about it.
