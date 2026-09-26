# Architecture decision records

Every locked design decision in Railroad Network is written down as an
Architecture Decision Record (ADR) in the `station` repo. ADRs are
append-only: a changed decision gets a new ADR that supersedes the old one.
When a page on this site and an ADR disagree, **the ADR wins**.

> **Phase numbering.** ADRs written before 2026-08-25 use the old phase
> numbering, where "Phase 2" meant federation. ADR-0017 resequenced the
> plan: Phase 2 is now single-community resilience and Phase 3 is federation.
> ADRs 0001 to 0016 keep the old numbering as written.

The **Status** column is the ADR's own status line. *Proposed* on a decision
that has shipped means the maintainer has not yet formally ratified it; the
code follows it regardless.

| ADR | Decision | Status |
| --- | --- | --- |
| [0001](https://github.com/railroad-network/station/blob/main/docs/adr/0001-rust-workspace-and-dual-license.md) | Rust workspace and dual license | Accepted |
| [0002](https://github.com/railroad-network/station/blob/main/docs/adr/0002-canonical-serialization-dcbor.md) | Canonical serialization via deterministic CBOR (`dcbor`) | Accepted |
| [0003](https://github.com/railroad-network/station/blob/main/docs/adr/0003-bech32-address-format.md) | Human-readable address format: bech32m with HRP `rrn` | Accepted |
| [0004](https://github.com/railroad-network/station/blob/main/docs/adr/0004-own-shamir-implementation.md) | Own Shamir's Secret Sharing implementation over GF(256) | Accepted |
| [0005](https://github.com/railroad-network/station/blob/main/docs/adr/0005-station-signed-settlement.md) | The station signs settlement and cancellation records | Accepted |
| [0006](https://github.com/railroad-network/station/blob/main/docs/adr/0006-m1-client-architecture.md) | The mobile client holds the keys; the station is a local backend | Accepted |
| [0007](https://github.com/railroad-network/station/blob/main/docs/adr/0007-rust-mobile-ffi-uniffi.md) | uniffi-rs generates the mobile bindings to our Rust crypto | Accepted |
| [0008](https://github.com/railroad-network/station/blob/main/docs/adr/0008-mobile-station-transport.md) | The mobile↔station envelope is the security boundary; the transport is a dumb carrier | Accepted |
| [0009](https://github.com/railroad-network/station/blob/main/docs/adr/0009-universal-reputation-algorithm.md) | One reputation formula runs on every station and no community can tune it | Accepted |
| [0010](https://github.com/railroad-network/station/blob/main/docs/adr/0010-marketplace-data-model.md) | A listing is a signed record on the log; the search index is a view that can be thrown away | Accepted |
| [0011](https://github.com/railroad-network/station/blob/main/docs/adr/0011-oracle-tier-model-phase-1.md) | The Phase-1 oracle ladder: two serviceable tiers, a blocked ceiling, and a derived reputation stake | Accepted |
| [0012](https://github.com/railroad-network/station/blob/main/docs/adr/0012-charter-format-and-amendments.md) | The Charter: a self-bootstrapping constitutional document, and how a community changes it | Accepted |
| [0013](https://github.com/railroad-network/station/blob/main/docs/adr/0013-federation-transport-reticulum.md) | Federation and collapse-mode transport is pluggable; Reticulum is the adopted backend, run as an external sidecar | Accepted |
| [0014](https://github.com/railroad-network/station/blob/main/docs/adr/0014-phase-1-dispute-resolution.md) | Phase-1 dispute resolution: a sortition jury with a governance backstop, and the Tier-2 stake that finally bites | Accepted |
| [0015](https://github.com/railroad-network/station/blob/main/docs/adr/0015-electorate-bootstrap-grace.md) | Bootstrapping the electorate: a governance and dispute grace so a young community can actually govern | Accepted |
| [0016](https://github.com/railroad-network/station/blob/main/docs/adr/0016-station-backup-and-key-recovery.md) | Station backup and key recovery: an encrypted archive whose key survives a lost passphrase | Accepted |
| [0017](https://github.com/railroad-network/station/blob/main/docs/adr/0017-resilience-before-federation.md) | Single-community resilience comes before federation | Accepted |
| [0018](https://github.com/railroad-network/station/blob/main/docs/adr/0018-debt-floor.md) | A debt floor bounds how far a member can sign themselves into debt | Accepted |
| [0019](https://github.com/railroad-network/station/blob/main/docs/adr/0019-confirmation-freshness-bound.md) | A freshness bound on `confirmed_at` protects the dispute window | Accepted (superseded for delay-tolerant sync by ADR-0022) |
| [0020](https://github.com/railroad-network/station/blob/main/docs/adr/0020-single-writer-log-dtn-submission.md) | The community log keeps one writer; resilience is delay-tolerant submission, not multi-writer merge | Accepted |
| [0021](https://github.com/railroad-network/station/blob/main/docs/adr/0021-escrowed-offline-spending-certificates.md) | Escrowed offline spending certificates bound the debt floor under partition | Accepted |
| [0022](https://github.com/railroad-network/station/blob/main/docs/adr/0022-admission-clock-time-trust.md) | The admission clock: the station's clock at admission is the only window-bearing clock | Accepted |
| [0023](https://github.com/railroad-network/station/blob/main/docs/adr/0023-emergency-governance-modes.md) | Emergency governance: deciding faster in a crisis without building a coup lever | Accepted |
| [0024](https://github.com/railroad-network/station/blob/main/docs/adr/0024-station-at-rest-encryption-key-ceremony.md) | Station at-rest encryption: a member-keyed encrypted volume unlocked by a boot ceremony | Accepted |
| [0025](https://github.com/railroad-network/station/blob/main/docs/adr/0025-equivocation-dispute-cases.md) | Equivocation cases are a distinct jury case kind with a Lapsed default and identity-anchored sortition | Accepted |
| [0026](https://github.com/railroad-network/station/blob/main/docs/adr/0026-reticulum-sidecar-ratified.md) | The Reticulum sidecar is ratified: pinned `rnsd` 1.5, driven from the station, native Rust deferred | Accepted |
| [0027](https://github.com/railroad-network/station/blob/main/docs/adr/0027-emergency-declaration-activation-and-ttl.md) | Emergency declaration activation is a single first-crossing event, and a part-signed declaration expires | Accepted |
| [0028](https://github.com/railroad-network/station/blob/main/docs/adr/0028-non-mobile-member-wallet.md) | A self-custody CLI member wallet: the non-mobile member device, a sealed-channel client with an offline outbox | Accepted |
| [0029](https://github.com/railroad-network/station/blob/main/docs/adr/0029-federation-identity-profiles-and-carriage.md) | Federation identity, community profiles, and the federation carriage protocol | Accepted |
| [0030](https://github.com/railroad-network/station/blob/main/docs/adr/0030-treaties-ratification-depth-lifecycle.md) | Treaties: ratification, depth, lifecycle, and suspension | Accepted |
| [0031](https://github.com/railroad-network/station/blob/main/docs/adr/0031-cross-community-credit-treaty-accounts.md) | Cross-community credit: treaty accounts and the prepare/commit protocol | Accepted |
| [0032](https://github.com/railroad-network/station/blob/main/docs/adr/0032-recognition-portable-standing-cross-community-marketplace.md) | Recognition: portable standing across communities and the cross-community marketplace | Accepted |
| [0033](https://github.com/railroad-network/station/blob/main/docs/adr/0033-oracle-tiers-3-and-4.md) | Oracle Tiers 3 and 4: artifact evidence, witnesses, and cross-community validation | Accepted |
| [0034](https://github.com/railroad-network/station/blob/main/docs/adr/0034-community-tribunal-and-federation-arbitration.md) | The community tribunal and federation arbitration | Accepted |
| [0035](https://github.com/railroad-network/station/blob/main/docs/adr/0035-writer-succession-and-lineage-pinning.md) | Writer succession and lineage-aware signer pinning | Accepted |
| [0036](https://github.com/railroad-network/station/blob/main/docs/adr/0036-predictive-matching-v0.md) | Predictive matching, version 0 | Accepted |
| [0037](https://github.com/railroad-network/station/blob/main/docs/adr/0037-localization-codes-on-the-wire-readers-translate.md) | Localization: the wire carries codes, readers translate | Accepted |

> **Generated page.** Built from `docs/adr/` in the `station` repo by
> `scripts/gen-reference.sh`.
