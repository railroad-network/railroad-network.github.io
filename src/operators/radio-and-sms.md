# Radio and text message

Between "phones on the station's Wi-Fi" and "a printed sheet in a pocket" sit
two electronic carriers. **LoRa radio** moves signed records kilometres with
no infrastructure at all. **Text message** could move them anywhere a phone
has signal. One is built and bench-proven; the other stops at a software seam.
This page says which is which and how to bring the radio up.

Both are **dumb carriers**. They see only signed, already-public records. They
are never the identity, the integrity, or the encryption boundary: a record
that crosses a radio is checked at the station exactly as if a courier had
walked it in. That is locked in
[ADR-0013](https://github.com/railroad-network/station/blob/main/docs/adr/0013-federation-transport-reticulum.md).

## What each one leaks

Content is community-public either way. What a carrier adds is **metadata**:
a radio has a location and a traffic pattern; a phone number has an owner and
a carrier that logs who texted whom, and when. A community under surveillance
pressure should route sensitive traffic on [paper](courier-desk.md), which has
no electronic trace, and treat radio and SMS as conveniences for reach.

## LoRa radio

The station does not speak radio itself. It supervises **Reticulum**, a mesh
networking stack that drives LoRa boards running the RNode firmware, and
carries bundles over it. Adding a radio is a firmware and configuration
change, not a code change.

### Status

| Piece | State |
| --- | --- |
| Reticulum sidecar, supervised by the station | Built. Off by default. |
| Bundle push and receipt over the radio | Built. Two radios verified over the air on the bench on 2026-09-11. |
| Airtime budget, money-first pacing | Built. |
| Field acceptance at real range | **Pending**: a human sign-off with the checklist in the bring-up guide. |

The full procedure, with board compatibility, flashing, the regional
compliance table, airtime presets, and the acceptance checklist, is the
[LoRa radio bring-up guide](https://github.com/railroad-network/station/blob/main/docs/lora-radio-bringup.md)
in the `station` repo. This page is the map; that guide is the territory.

### Hardware

You need **two** radios to test a link: one at the station, one at a peer. A
board must carry a Semtech LoRa transceiver, be on the RNode firmware's
supported list (LilyGO T-Beam and T3, Heltec LoRa32, RAK4631-class boards are
common choices), and match your regional band on both ends. The definitive
check takes five minutes and no code:

```sh
pipx install "rns==1.5.2" "lxmf==1.1.1"   # Reticulum, pinned to the version the station manages
rnodeconf --autoinstall                    # detects the board; offers firmware only if supported
```

A board that `rnodeconf` does not recognise is not an RNode target. Test with a
known-good board instead.

### The sidecar

The station runs the Reticulum daemon as a managed child: version-pinned,
restarted with backoff, killed cleanly on shutdown. Its loss is a connectivity
event, never a reason the station exits. Two things before you enable it:

- **Install it yourself.** Reticulum is not bundled. The station refuses to
  manage a version other than the one it was validated against, any `1.5.x`.
- **Know what you are installing.** Reticulum is under its own licence,
  permissive but with two use restrictions, and not an OSI-approved one. The
  station never links it; by enabling the sidecar you choose to run that
  separate program. If that is a problem for your community, leave it off.
  Nothing else depends on it.

Then, in the station's `config.toml`:

```toml
[sidecar]
enabled = true                 # off by default

[lora]
# An absolute path: the station resolves it against its working directory,
# which is "/" under systemd.
adapter_script = "/opt/railroad/station/scripts/reticulum/lxmf_adapter.py"

[lora.rnode]
port = "/dev/ttyACM0"          # the radio's serial port
frequency_hz = 867200000       # NO default: must be legal for your region
tx_power_dbm = 7               # NO default: start low, respect your region's cap
# bandwidth_hz = 125000        # optional, defaults shown; must match on every node
# spreading_factor = 8
# coding_rate = 5
```

On first run the station writes a Reticulum configuration under the data
directory with the matching radio interface, and never overwrites your edits
afterwards. If `[lora.rnode]` is absent, the generated configuration carries a
commented example and a pointer to the guide instead. **The station never
transmits on a frequency or power that nobody chose.**

> **Warning.** Choosing a frequency, power, and duty cycle that are legal where
> you operate is your responsibility, and it varies by country. Antenna gain
> counts toward the radiated-power cap. The bring-up guide has a starting
> table by region and links to the regulators; confirm before keying up, and
> when in doubt transmit at the lowest power that carries the link.

> **Tip.** If the station already ran once before you added `[lora.rnode]`,
> the generated Reticulum config is on disk without a radio and is not
> regenerated. Delete it (the station rewrites it on the next start) or add
> the interface stanza by hand.

### The airtime budget

LoRa is slow, and duty-cycle rules make sustained throughput slower still:
single-digit bytes per second in the conservative European setting. The
station paces to a budget of `raw_bytes_per_sec × duty_cycle_percent / 100`
and sends **money before governance before bulk**, so a payment never waits
behind a marketplace listing. The defaults are the conservative setting.
After a link test, measure your real on-air rate and set the budget to it;
the guide has presets per region. Every key is in the
[configuration reference](../reference/configuration.md).

### Watching traffic cross

```sh
rrn status          # the connectivity block: sidecar disabled / running / degraded / restarting
rrn dtn status      # every tracked push: peer, records, state, attempts, and the receipt's outcome
```

A push goes `queued`, then `delivered` once the peer's signed receipt
correlates back, or `abandoned` after a week of retries. Nothing is dropped
silently. To send by hand:

```sh
rrn dtn bind --destination <this station's Reticulum hex>   # publish your own reachability
rrn dtn push --peer <peer hex> --bundle payload.bundle      # returns "queued"; watch status
```

A member on the command-line wallet produces `payload.bundle` with
`rrn wallet export bundle`, having signed with `--carrier slow` so the record
survives a slow link. The receiving member gets their receipt the normal way:
a sync when they next reach the writer's network, or a receipt sheet from the
[courier desk](courier-desk.md). A push's status line shows only a summary,
not the receipt bytes.

### The scripted acceptance run

`scripts/field-test-lora.sh` in the `station` repo drives one signed bundle
across the radio and confirms the receipt returns, printing pass or fail per
stage. Start a station on each of two machines yourself, then run the
receiver role first (it prints the destination hex the sender needs) and the
sender role second. `--dry-run` rehearses every stage with no hardware and is
what continuous integration runs.

Two `rnsd` instances cannot share one host, so this is two machines, not one.

## Text message

SMS is designed as a **carrier for already-signed records**, never as a way
to command the station. A phone with cellular text but no data encodes its
outbox into text chunks, texts them to the station's number, and the station
texts the signed receipt back. The feature-phone model, a person texting
`PAY 5 TO ALICE` with the station holding their keys, is out of scope by
decision: keys stay with members
([ADR-0006](https://github.com/railroad-network/station/blob/main/docs/adr/0006-m1-client-architecture.md)).

### Status

| Piece | State |
| --- | --- |
| Wire codec: records as text chunks that survive a carrier's mangling | Built and tested. |
| Sender registry: a member binds their own number with a signed record | Built. |
| Per-sender rate cap, money-first outbound pacing | Built. |
| Station relay, tested against a mock gateway | Built. |
| **The physical modem gateway** | **Not built.** |
| The app composing texts | Not built. |

Because there is no gateway, **SMS cannot be switched on today**. The `[sms]`
section of the configuration exists and is off by default; an enabled section
without a modem backend is supervised but idle. When the gateway lands it
will be a local USB GSM modem, not a cloud texting service, so that it works
with no account and no internet, the same posture as the radio.

What is built is enough to know how it will behave:

- **The sender registry is spam control, not security.** A sender number is
  forgeable; the signatures inside the texts are the boundary. The default
  policy processes texts only from numbers a member has bound to their
  identity. The rate cap is sixty inbound texts per sender per hour.
- **There is no acknowledgement protocol in SMS.** Reliability is re-send
  driven, exactly like paper: a member keeps texting their outbox until the
  receipt comes back, and the station re-ingests idempotently.
- **The carrier sees everything**: both numbers, the timing, and the bytes.
  The bytes are public signed records; the numbers and timing are the leak.

The format is pinned in the
[SMS carrier spec](https://github.com/railroad-network/station/blob/main/docs/spec/sms-carrier.md).

## Where each carrier fits

| Situation | Reach for |
| --- | --- |
| Members on the community Wi-Fi | Nothing extra: phones and wallets sync directly. |
| A member across the valley, no internet either end | Radio, if both ends have one. Otherwise paper. |
| Sensitive traffic, surveillance pressure | Paper. No electronic trace. |
| Cellular signal but no data | Paper today. SMS once the gateway exists. |
| Volume too large for a sheet | A bundle on a USB stick, or the radio. |

All of them end at the same front door. Whatever the carrier, the station
checks every signature, every nonce, and every window as if the member had
been standing in front of it.
