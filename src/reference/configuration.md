# Configuration

Every setting a station reads lives in one file, `config.toml`, in its data
directory. This page lists every key with its default and what it means.

> **Hand-written from the source.** This page mirrors the `[StationConfig]`
> structs in `crates/rrn-station/src/config.rs` of the `station` repo, which
> are the authority. It is not generated. If a key here and the code disagree,
> the code is right and this page needs an edit; re-check it whenever a change
> to that file lands.

## Where it lives and how it is created

The data directory is `~/.railroad/station` unless you pass `--data-dir` to
`station`. `station init` creates the directory and writes a default
`config.toml`: a writer with no peers, listening for other stations on a
loopback port chosen at random between 7400 and 7499, and every other section
at its default. Every section except `[network]` may be omitted entirely and
takes its defaults.

A malformed file is an error with a line number. It is never silently
replaced. The station reads the file once at start; edit it, then restart.

Values are TOML: strings in quotes, numbers bare, lists in square brackets.
Amounts are in **centicommons**, whole numbers, one hundredth of a Common.
Durations are in seconds.

## Two complete examples

A community's station, the normal case. It **owns** the log and never pulls
from anyone, so it has no peers:

```toml
[network]
listen = "127.0.0.1:7400"      # station-to-station port; loopback is correct for a lone writer
role = "writer"                # the default

[mobile]
listen = "0.0.0.0:7500"        # where phones and command-line wallets connect
advertise = true               # announce on the LAN so the app finds it by name
# name = "Railroad Station — Maple Street"
```

An optional read-only **replica** of that writer, for audit or an off-site
copy. It pulls the writer's log and admits nothing:

```toml
[peers]
list = ["192.168.4.1:7400"]    # the writer's [network] listen address

[network]
listen = "127.0.0.1:7401"
role = "replica"
```

A writer with a non-empty `[peers] list` **refuses to start** and names the
fix. A replica with an empty list is valid but useless, and the station warns.
The rule is
[ADR-0020](https://github.com/railroad-network/station/blob/main/docs/adr/0020-single-writer-log-dtn-submission.md):
one log, one writer.

## `[network]`

Where this station accepts connections from *other stations*, and its role.
This is a different port and protocol from the one phones use.

| Key | Default | Meaning |
| --- | --- | --- |
| `listen` | `"127.0.0.1:74xx"` (random on `init`) | `host:port` for inbound station-to-station connections. Required. A writer still serves this port so a replica can copy from it. |
| `role` | `"writer"` | `"writer"` owns the community's log, admits records at its own front door, and never pulls. `"replica"` pulls the writer's log and refuses every write: the console, the phone channel, and courier ingest all answer that this station is a read-replica, and the sweeps that would append records do not run. A replica is not a failover. |

## `[peers]`

| Key | Default | Meaning |
| --- | --- | --- |
| `list` | `[]` | `host:port` of each station this one pulls the log from. Must be empty on a writer. Configure peers by IP address, not hostname: a dead resolver can stall shutdown. |

## `[mobile]`

How paired phones and command-line wallets reach this station.

| Key | Default | Meaning |
| --- | --- | --- |
| `listen` | `"0.0.0.0:7500"` | `host:port` of the member-facing listener. Must be reachable from the LAN, so it defaults to all interfaces. 7500 is what the app expects. |
| `name` | *(derived)* | The name advertised on the local network. When omitted it is derived from the station's own address, so it is stable across restarts and distinct between stations. |
| `advertise` | `true` | Whether to announce on the LAN at all. `false` runs dark: members must type the station's address and port by hand. |
| `subscribe_hold_secs` | `30` | How long a phone's long-poll is held open before an empty heartbeat is returned. |

## `[settlement]`

The delay between a payment being confirmed and balances moving, per tier.
The rule is [ADR-0011](https://github.com/railroad-network/station/blob/main/docs/adr/0011-oracle-tier-model-phase-1.md).

| Key | Default | Meaning |
| --- | --- | --- |
| `window_seconds` | *(unset)* | A uniform override for **every** tier, in seconds. Meant for demos and drills, where a few seconds lets settlements land the same afternoon. When set it wins over the two keys below. Leave it unset in real use. |
| `tier1_window_seconds` | `86400` (24 hours) | The settlement window for a Tier 1 payment. |
| `tier2_window_seconds` | `172800` (48 hours) | The settlement window for a Tier 2 payment. |

## `[credit]`

How far into debt a member may sign themselves, and the headroom certificates
that reserve credit ahead of an outage. The rules are
[ADR-0018](https://github.com/railroad-network/station/blob/main/docs/adr/0018-debt-floor.md)
and [ADR-0021](https://github.com/railroad-network/station/blob/main/docs/adr/0021-escrowed-offline-spending-certificates.md).

| Key | Default | Meaning |
| --- | --- | --- |
| `debt_floor_centi` | `-2000` (−20 Commons) | The lowest projected balance a member may commit to. Must be 0 or negative. Lowering it is a community decision, not a personal one; a governance-set floor is later work, so today it is the operator's knob. |
| `cert_validity_seconds` | `604800` (7 days) | How long a newly issued certificate stays valid. Must be greater than 0. |
| `cert_max_cap_centi` | `1000` (10 Commons) | The most one certificate may reserve. Must be greater than 0 and **less than 5,000** (the Tier 3 floor of 50 Commons): certificates are for everyday trade, not exceptional transfers. A cap larger than the debt floor's magnitude only warns, since a member at zero balance could never fill it. |
| `cert_delivery_grace_seconds` | `1209600` (14 days) | How long after a certificate expires a spend against it may still *arrive* and be admitted, to allow for slow carriers. Must be 0 or more. |
| `cert_max_outstanding` | `4` | How many live certificates one member may hold at once. Must be at least 1. |

## `[timers]`

How often each background sweep fires. All in seconds. The defaults suit a
pilot; a demo shortens the first two.

| Key | Default | Meaning |
| --- | --- | --- |
| `sweep_interval_secs` | `30` | The settlement sweep: settles every confirmed payment whose window has elapsed. |
| `gossip_interval_secs` | `5` | How often a replica pulls from its peers. |
| `reputation_refresh_interval_secs` | `3600` (1 hour) | Recomputes the cached standing of every known member from the log. The cache is only a cache. |
| `listing_expiry_interval_secs` | `300` (5 minutes) | Writes down marketplace listings whose expiry has passed. They are already unbuyable the moment they expire. |
| `inquiry_expiry_interval_secs` | `3600` (1 hour) | Closes marketplace inquiries idle for seven days. |
| `contract_charge_interval_secs` | `300` (5 minutes) | Bills every period a recurring service contract has due. Re-sweeping a period is harmless. |
| `governance_implementation_interval_secs` | `3600` (1 hour) | Puts passed proposals whose implementation delay has run into force. |
| `dispute_resolution_interval_secs` | `3600` (1 hour) | Enacts jury majorities and lapses disputes whose window closed unresolved. |
| `dtn_prune_interval_secs` | `3600` (1 hour) | Removes delivery-receipt tracking past its retention (see `[dtn]`). |

On a replica the sweeps that would append to the log do not run.

## `[dtn]`

Delay-tolerant delivery: the receipts the station signs for records that
arrive by courier, paper, radio, or text.

| Key | Default | Meaning |
| --- | --- | --- |
| `receipt_retention_secs` | `2592000` (30 days) | How long a receipt the author has already picked up is kept. A receipt nobody has collected yet is kept four times as long, since a courier may take weeks to carry it home. |

## `[sidecar]`

The supervised Reticulum daemon, `rnsd`, which carries traffic over mesh and
LoRa radio. Off by default. Reticulum is strictly a carrier and never the
security boundary, per
[ADR-0013](https://github.com/railroad-network/station/blob/main/docs/adr/0013-federation-transport-reticulum.md)
and [ADR-0026](https://github.com/railroad-network/station/blob/main/docs/adr/0026-reticulum-sidecar-ratified.md).
You install `rnsd` yourself; see [Radio and text message](../operators/radio-and-sms.md).

| Key | Default | Meaning |
| --- | --- | --- |
| `enabled` | `false` | Whether to run the sidecar at all. |
| `rnsd_path` | `"rnsd"` | Path to, or name of, the `rnsd` binary. |
| `config_dir` | `<data dir>/reticulum` | Where the generated Reticulum configuration lives. Generated once and never overwritten, so your edits survive. |
| `pinned_version` | `"1.5"` | The `rnsd` version this station is validated against, as a dotted prefix: `"1.5"` accepts any `1.5.x`; `"1.5.2"` only that release. A mismatch runs the station *without* the sidecar. |
| `allow_version_drift` | `false` | Development escape hatch: run a mismatched `rnsd` anyway, with a loud warning. |
| `restart_backoff_secs` | `5` | Base delay before restarting a sidecar that exited. Doubles per consecutive failure, capped at 300; resets once it has stayed up. |
| `tcp_listen` | *(unset)* | A `host:port` for `rnsd` to accept inbound Reticulum links on. Omitted means no listener is generated. |
| `tcp_peers` | `[]` | `host:port` targets `rnsd` dials out to, one interface each. |

A crashed or degraded sidecar never takes the station down. `rrn status`
shows its state.

## `[lora]`

The airtime budget the radio transport paces to, and the adapter that drives
it. Radio throughput is small and duty-cycle rules cut it further; the station
sends money before governance before bulk.

| Key | Default | Meaning |
| --- | --- | --- |
| `raw_bytes_per_sec` | `250.0` | Raw carrier throughput before the duty cycle. |
| `duty_cycle_percent` | `1.0` | Duty cycle as a percentage; `1.0` is 1%, the conservative EU-868 ceiling. A laxer region may raise it. Sustained throughput is raw × duty ÷ 100. |
| `burst_bytes` | `500` | The largest catch-up burst after idle, and the largest single frame the budget passes. Must be at least `frame_bytes`. |
| `frame_bytes` | `480` | The largest carrier frame the framing layer targets. |
| `adapter_script` | *(unset)* | Path to the LXMF adapter script (`scripts/reticulum/lxmf_adapter.py` in the `station` repo). Set this **and** enable `[sidecar]` and delay-tolerant traffic flows over Reticulum. Unset, the sidecar is supervised but carries nothing. |
| `adapter_python` | `"python3"` | The interpreter that has the `rns` and `lxmf` packages. |
| `push_rescan_secs` | `3600` (1 hour) | How often undelivered outbound pushes are re-sent. |
| `push_ttl_secs` | `604800` (7 days) | How long an undelivered push is retried before being marked abandoned. Never silently dropped; `rrn dtn status` shows it. |

## `[lora.rnode]`

The physical RNode LoRa radio. Absent by default: **a station never transmits
on a frequency or power nobody chose.** Spectrum compliance is the operator's
responsibility per region, and every node on one network must share frequency,
bandwidth, and spreading factor. See [Radio and text message](../operators/radio-and-sms.md).

| Key | Default | Meaning |
| --- | --- | --- |
| `port` | *(required)* | The radio's serial port, such as `/dev/ttyACM0` or `/dev/ttyUSB0`. |
| `frequency_hz` | **none** | Centre frequency in hertz. Must be legal where you are and identical on every node. |
| `tx_power_dbm` | **none** | Transmit power in dBm. Start low; antenna gain counts toward your region's cap. |
| `bandwidth_hz` | `125000` | Channel bandwidth. |
| `spreading_factor` | `8` | 7 to 12. Higher reaches further and sends less. |
| `coding_rate` | `5` | The denominator of the 4/x coding rate; 5 to 8. |

## `[sms]`

Text messages as a carrier for records a member's phone already signed. Off
by default, and **the modem gateway that would carry the texts is not built**:
enabling this section today leaves the carrier supervised but idle. The format
is in the [wire specifications](specs.md).

| Key | Default | Meaning |
| --- | --- | --- |
| `enabled` | `false` | Whether the SMS carrier is enabled at all. |
| `station_msisdn` | *(unset)* | The station's own phone number, the one members text. Required once a gateway exists. |
| `max_parts_per_message` | `4` | The most concatenated parts one text may span. Must be at least 1. |
| `allowed_senders` | `"paired"` | `"paired"` processes only numbers a member has bound to their identity; `"open"` processes any number. Both still check every signature; this is spam control, not security. |
| `max_inbound_per_hour` | `60` | The most texts one sender may send per hour before the rest are dropped. |

## `[storage]`

The at-rest profile. Chosen when the station is provisioned, not a runtime
toggle. The encrypted profile is
[ADR-0024](https://github.com/railroad-network/station/blob/main/docs/adr/0024-station-at-rest-encryption-key-ceremony.md);
see [Encrypted at rest](../operators/encrypted-at-rest.md).

| Key | Default | Meaning |
| --- | --- | --- |
| `at_rest` | `"plaintext"` | `"plaintext"` is a flat, unencrypted data directory with only the wallet key encrypted. `"encrypted"` keeps everything sensitive inside a member-keyed LUKS2 container unlocked by a boot ceremony. **Linux only**: on any other host the encrypted profile refuses to start rather than serve plaintext. |

## `[storage.encrypted]`

Read only when `at_rest = "encrypted"`. Written for you by
`station encrypt-in-place`.

| Key | Default | Meaning |
| --- | --- | --- |
| `container_path` | `<boot dir>/state.img` | The LUKS2 container file. |
| `state_dir` | `<boot dir>/state` | Where the unlocked container is mounted. |
| `threshold` | `3` | How many holders must cooperate at the boot ceremony. At least 2, and no more than the number of holders. |

The holder set is deliberately **not** stored here. A list of holders on the
unencrypted boot directory would hand whoever seized the machine a list of
people to pressure. The authoritative record lives inside the container and is
readable, once unlocked, with `station vmk status`.

## Environment variables

| Variable | Read by | Meaning |
| --- | --- | --- |
| `RRN_PASSPHRASE` | `station` | The station's wallet passphrase, for `init`, `run`, and the other daemon commands. When unset you are prompted. Never put it on a command line; a root-only environment file for a service manager is the accepted trade. |
| `RRN_NEW_PASSPHRASE` | `station` | The *new* passphrase chosen at the end of a key-recovery ceremony. Prompted for when unset. |
| `RRN_LOG` | `station` | The log filter, in `tracing` syntax. Default `info,tantivy=warn`. |
| `RRN_WALLET_PASSPHRASE` | `rrn wallet` | The member wallet's passphrase. Deliberately a different variable from the station's, so one shell cannot leak the other. Prompted for when unset. |
| `RRN_WALLET_HOME` | `rrn wallet` | The wallet directory. `--home` on the command line wins over it; the default is `~/.railroad/wallet`. |

The `rrn` console finds the station's socket at
`~/.railroad/station/station.sock`; pass `--socket` for a station elsewhere.

## The data directory

**Plaintext profile.** One flat directory, `~/.railroad/station` by default:

| File | What it is | Back it up? |
| --- | --- | --- |
| `wallet.rrnwallet` | The station's identity key, encrypted under the passphrase. | Yes. Irreplaceable. |
| `station.db` | The community's log and everything derived from it. | Yes. Irreplaceable. |
| `paired_mobiles.json` | Which phones and wallets are paired. | Yes. Losing it means re-pairing everyone. |
| `config.toml` | This page. | Yes. |
| `recovery.rrnrecovery` | The station's key-recovery package, once armed. | Yes. |
| `station.sock` | The console socket. | No. Runtime scratch. |
| `marketplace_index/` | The search index. | No. Rebuilt from the log. |
| `reticulum/` | The generated Reticulum configuration and adapter identity, when the sidecar is on. | Optional. |

`station backup` bundles the right ones into a single encrypted archive.

**Encrypted profile.** The directory you pass as `--data-dir` becomes the
unencrypted **boot directory**, holding only `config.toml`, `station.sock`,
the container `state.img`, and a tiny `vmk.descriptor` that records the
threshold and nothing about who the holders are. Everything else above lives
inside the container, mounted at `state/` once unlocked, alongside
`vmk.rrnrecovery`, the full holder record. Backups cover what is inside the
container but not the boot directory's `config.toml`, so keep a copy of that
file with your archives.
