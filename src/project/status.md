# Status and roadmap

*Last updated 2026-09-22.*

Railroad Network is built in phases, each meant to be useful on its own.

| Phase | Scope | State |
| --- | --- | --- |
| 0 | Crypto core, signed log, identity, ledger, daemon and CLI | Done |
| 1 | Mobile app, vouching, standing, marketplace, oracle tiers 1 and 2, governance, disputes, pilot readiness | Done; the 90-day community pilot has not yet been run |
| 2 | Single-community resilience: offline-first, delay-tolerant sync, headroom certificates, paper, LoRa radio, SMS codec, emergency governance, encrypted at rest, the command-line wallet | Done on simulation evidence, closed 2026-09-13; two hardware sign-offs pending |
| 3 | Federation between communities | Not started |

> **Phase numbering.** Documents written before 2026-08-25 call federation
> "Phase 2". A decision record (ADR-0017) moved single-community resilience
> ahead of federation, so resilience became Phase 2 and federation Phase 3.
> Older decision records keep the old numbering as written.

## What works today

- One community: one writer station and the phones and laptops that pair with
  it, plus an optional read-only replica for audit.
- Payments with settlement windows and a debt floor. Tiers 1 and 2.
- Vouching, computed standing, established members, bootstrap grace.
- A marketplace: listings, needs, inquiries, recurring contracts.
- Charter founding ceremony, proposals, co-signing, voting, statutes.
- Jury disputes by sortition, escalation, appeal, equivocation cases.
- Emergency governance with a two-thirds declaration and hard expiry.
- Every window and electorate anchored on the station's admission clock, so a
  device's clock cannot move a deadline.
- Offline signing into a durable outbox, headroom certificates, delivery by
  courier, paper, or LoRa radio, and signed receipts, **from the command-line
  wallet** (see the next section for the phone).
- Encrypted station backups, station key recovery held by members, member key
  recovery from a recovery circle on a new phone or laptop, and an optional
  encrypted at-rest profile unlocked by a member quorum.
- A self-custody command-line wallet for members without a phone.
- A 72-hour outage simulation that runs in seconds and checks conservation,
  the debt floor, forks, and reproducibility.

## What does not work yet

- **The phone app cannot sign while the station is out of reach.** Sending,
  confirming, voting, and contesting from the app need the station reachable;
  the app says so and you retry later. The offline outbox, headroom
  certificates, and paper export described on
  [When the network is down](../members/when-the-network-is-down.md) exist in
  the app's Rust core and ship today in the
  [command-line wallet](../members/using-a-computer.md); the phone screens are
  not written.
- **No federation.** Communities cannot see or trade with each other.
- **No Tier 3 or higher.** Payments of 50 Commons and up are refused.
- **No SMS gateway.** The codec, sender registry, and relay are built and
  tested against a mock; the physical modem side is not, so text message
  cannot be switched on.
- **LoRa field sign-off pending.** The radios are bench-verified over the
  air; the field-acceptance run at real range has not been recorded.
- **No app store, no iOS.** Android, sideloaded.
- **No per-member rate limiting** on any surface, accepted at pilot scale
  behind the pairing gate.
- **No independent audit.** See [Security and audits](security.md).

## The pilot

What remains of Phase 1 is running the real thing: a 90-day pilot with a
community of around twenty people, play stakes, one station. The guides on
this site were written for it. If you run one, the project wants to hear
about it: see [Contributing](contributing.md).
