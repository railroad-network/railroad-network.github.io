# Architecture decision records

Every locked design decision in Railroad Network is written down as an
Architecture Decision Record (ADR) in the `station` repo. ADRs are
append-only: a changed decision gets a new ADR that supersedes the old one.
When a page on this site and an ADR disagree, **the ADR wins**.

> **Phase numbering.** ADRs written before 2026-08-25 use the old phase
> numbering, where "Phase 2" meant federation. ADR-0017 resequenced the
> plan: Phase 2 is now single-community resilience and Phase 3 is federation.
> ADRs 0001 to 0016 keep the old numbering as written.

| ADR | Decision |
| --- | --- |
| [0001](https://github.com/railroad-network/station/blob/main/docs/adr/0001-rust-workspace-and-dual-license.md) | Rust workspace and dual license |
| [0002](https://github.com/railroad-network/station/blob/main/docs/adr/0002-canonical-serialization-dcbor.md) | Canonical serialization via deterministic CBOR (`dcbor`) |
| [0003](https://github.com/railroad-network/station/blob/main/docs/adr/0003-bech32-address-format.md) | Human-readable address format: bech32m with HRP `rrn` |
| [0004](https://github.com/railroad-network/station/blob/main/docs/adr/0004-own-shamir-implementation.md) | Own Shamir's Secret Sharing implementation over GF(256) |
| [0005](https://github.com/railroad-network/station/blob/main/docs/adr/0005-station-signed-settlement.md) | The station signs settlement and cancellation records |
| [0006](https://github.com/railroad-network/station/blob/main/docs/adr/0006-m1-client-architecture.md) | The mobile client holds the keys; the station is a local backend |
| [0007](https://github.com/railroad-network/station/blob/main/docs/adr/0007-rust-mobile-ffi-uniffi.md) | uniffi-rs generates the mobile bindings to our Rust crypto |
| [0008](https://github.com/railroad-network/station/blob/main/docs/adr/0008-mobile-station-transport.md) | The mobile↔station envelope is the security boundary; the transport is a dumb carrier |
| [0009](https://github.com/railroad-network/station/blob/main/docs/adr/0009-universal-reputation-algorithm.md) | One reputation formula runs on every station and no community can tune it |
| [0010](https://github.com/railroad-network/station/blob/main/docs/adr/0010-marketplace-data-model.md) | A listing is a signed record on the log; the search index is a view that can be thrown away |
| [0011](https://github.com/railroad-network/station/blob/main/docs/adr/0011-oracle-tier-model-phase-1.md) | The Phase-1 oracle ladder: two serviceable tiers, a blocked ceiling, and a derived reputation stake |
| [0012](https://github.com/railroad-network/station/blob/main/docs/adr/0012-charter-format-and-amendments.md) | The Charter: a self-bootstrapping constitutional document, and how a community changes it |
| [0013](https://github.com/railroad-network/station/blob/main/docs/adr/0013-federation-transport-reticulum.md) | Federation and collapse-mode transport is pluggable; Reticulum is the adopted backend, run as an external sidecar |
| [0014](https://github.com/railroad-network/station/blob/main/docs/adr/0014-phase-1-dispute-resolution.md) | Phase-1 dispute resolution: a sortition jury with a governance backstop, and the Tier-2 stake that finally bites |
| [0015](https://github.com/railroad-network/station/blob/main/docs/adr/0015-electorate-bootstrap-grace.md) | Bootstrapping the electorate: a governance and dispute grace so a young community can actually govern |
| [0016](https://github.com/railroad-network/station/blob/main/docs/adr/0016-station-backup-and-key-recovery.md) | Station backup and key recovery: an encrypted archive whose key survives a lost passphrase |
| [0017](https://github.com/railroad-network/station/blob/main/docs/adr/0017-resilience-before-federation.md) | Single-community resilience comes before federation |
| [0018](https://github.com/railroad-network/station/blob/main/docs/adr/0018-debt-floor.md) | A debt floor bounds how far a member can sign themselves into debt |
| [0019](https://github.com/railroad-network/station/blob/main/docs/adr/0019-confirmation-freshness-bound.md) | A freshness bound on `confirmed_at` protects the dispute window |
| [0020](https://github.com/railroad-network/station/blob/main/docs/adr/0020-single-writer-log-dtn-submission.md) | The community log keeps one writer; resilience is delay-tolerant submission, not multi-writer merge |
| [0021](https://github.com/railroad-network/station/blob/main/docs/adr/0021-escrowed-offline-spending-certificates.md) | Escrowed offline spending certificates bound the debt floor under partition |
| [0022](https://github.com/railroad-network/station/blob/main/docs/adr/0022-admission-clock-time-trust.md) | The admission clock: the station's clock at admission is the only window-bearing clock |
| [0023](https://github.com/railroad-network/station/blob/main/docs/adr/0023-emergency-governance-modes.md) | Emergency governance: deciding faster in a crisis without building a coup lever |
| [0024](https://github.com/railroad-network/station/blob/main/docs/adr/0024-station-at-rest-encryption-key-ceremony.md) | Station at-rest encryption: a member-keyed encrypted volume unlocked by a boot ceremony |
| [0025](https://github.com/railroad-network/station/blob/main/docs/adr/0025-equivocation-dispute-cases.md) | Equivocation cases are a distinct jury case kind with a Lapsed default and identity-anchored sortition |
| [0026](https://github.com/railroad-network/station/blob/main/docs/adr/0026-reticulum-sidecar-ratified.md) | The Reticulum sidecar is ratified: pinned `rnsd` 1.5, driven from the station, native Rust deferred |
| [0027](https://github.com/railroad-network/station/blob/main/docs/adr/0027-emergency-declaration-activation-and-ttl.md) | Emergency declaration activation is a single first-crossing event, and a part-signed declaration expires |
| [0028](https://github.com/railroad-network/station/blob/main/docs/adr/0028-non-mobile-member-wallet.md) | A self-custody CLI member wallet: the non-mobile member device, a sealed-channel client with an offline outbox |

> **Generated page.** Built from `docs/adr/` in the `station` repo by
> `scripts/gen-reference.sh`.
