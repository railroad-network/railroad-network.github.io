# Run a station

This page gets a station from nothing to serving phones. It follows the
operator runbook in the `station` repo, which has more detail on every step.

## 1. Build the software

Install the Rust toolchain from [rustup.rs](https://rustup.rs), then:

```sh
git clone https://github.com/railroad-network/station.git
cd station
cargo build --release -p rrn-station -p rrn-cli
```

This produces two programs in `target/release/`:

- `station`, the **daemon**. Holds the wallet and ledger, talks to phones.
  This is the thing that runs forever.
- `rrn`, the **command-line client**. Your admin tool. It talks to the running
  daemon over a local socket and only works while the daemon is up.

Put both on your `PATH`, for example with
`sudo cp target/release/{station,rrn} /usr/local/bin/`.

## 2. Initialize

```sh
station init
```

You are prompted twice for a **wallet passphrase**. Choose it carefully. It
protects the station's identity key and encrypts every backup, and you type it
each time the station starts.

> **Write the passphrase down, on paper, in two places.** A passphrase that
> exists only in one person's head has already been lost twice in this
> project's own history. [Key recovery](backups-and-key-recovery.md) builds a
> net for a lost passphrase, but only if you set it up first.

`init` creates the data directory, `~/.railroad/station` by default, and
prints the station's `rrn1…` address. That address *is* the station's
identity.

| File | What it is |
| --- | --- |
| `wallet.rrnwallet` | The identity key, encrypted under your passphrase. Irreplaceable. |
| `station.db` | The community ledger. Irreplaceable. |
| `paired_mobiles.json` | Which phones are paired. Losing it means re-pairing everyone. |
| `config.toml` | Settings. |
| `station.sock`, `marketplace_index/` | Runtime scratch, rebuilt automatically. Never back these up. |

## 3. Configure

`config.toml` in the data directory. The defaults suit a single-community
pilot. The section you may want to touch is `[mobile]`:

```toml
[network]
listen = "127.0.0.1:7400"    # station-to-station port: loopback-only is correct today
role = "writer"              # this station owns the community's log (the default)

[mobile]
listen = "0.0.0.0:7500"      # where phones connect; 7500 is what the app expects
advertise = true             # announce the station on the LAN so phones find it by name
# name = "Railroad Station — Maple Street"   # optional friendly name shown on phones
```

Two practical notes:

- **Firewall.** Allow inbound TCP 7500 from your LAN. Port 7400 should stay
  unreachable from other machines.
- **Advertising.** `advertise = true` makes the station appear in the app's
  "Join your community" list. If your network blocks mDNS, members type the
  station's address and port by hand instead.

Your station is a **writer**: it owns the log and there is exactly one per
community. A writer has no peers. You can optionally run a second station as
a read-only **replica** for off-site audit; it can never write, so it can
never fork the community. The runbook covers it.

## 4. Run

```sh
station run
```

It prompts for the passphrase and serves until stopped. Check it is alive
from the same machine:

```sh
rrn whoami        # the station's rrn1… address
rrn history       # the ledger log, empty at first
```

### Surviving reboots

`station run` also reads the passphrase from the `RRN_PASSPHRASE` environment
variable. Never write the passphrase on a command line or in a script; it
lands in shell history. On Linux, a minimal systemd unit reads it from a
root-only file:

```ini
# /etc/systemd/system/rrn-station.service
[Unit]
Description=Railroad Network station
After=network-online.target
Wants=network-online.target

[Service]
User=railroad
EnvironmentFile=/etc/railroad/station.env   # RRN_PASSPHRASE=…; chmod 600, owned by root
ExecStart=/usr/local/bin/station run
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

```sh
sudo systemctl enable --now rrn-station
```

Keeping the passphrase on disk readable only by root is an accepted
pilot-grade trade so the station comes back by itself after a power cut. If
your community does not accept it, start the station by hand after each
reboot.

On macOS, fetch it from the keychain at the moment of use:

```sh
security add-generic-password -a "$USER" -s rrn-station-passphrase -w   # once
RRN_PASSPHRASE=$(security find-generic-password -s rrn-station-passphrase -w) station run
```

## Next

[Pair phones and wallets](pair-phones-and-wallets.md), then found the
community with your organizers, then, the same day,
[Backups and key recovery](backups-and-key-recovery.md).
