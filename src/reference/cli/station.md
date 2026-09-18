# `station` command reference

`station` is the daemon: it holds the community's wallet and log, runs settlement, talks to peers, and serves the `rrn` client over a Unix socket. Most of its subcommands are one-time or occasional operator tasks; `station run` is the long-running one.

> **Generated page.** This is the `--help` text of every command, captured from a
> build of the [`station`](https://github.com/railroad-network/station) repo
> by `scripts/gen-reference.sh`. Edit the help strings there, not this file.

## `station`

```text
The Railroad Network station daemon: holds the wallet and log, runs settlement, gossips with peers, and serves the rrn CLI over a Unix socket.

Usage: station [OPTIONS] [COMMAND]

Commands:
  init              Bootstrap a new station: generate an identity and initialize storage
  run               Run the daemon (default)
  peers             Inspect the static peer configuration
  pair-mobile       Confirm a mobile's pairing request (T1.3.3). With no address, lists the pending requests and their confirmation codes; pass an address to confirm it after comparing the code with the mobile's screen in person
  list-mobiles      List the mobiles currently paired with this station
  unpair            Revoke a mobile's pairing by its bech32 address
  backup            Write an encrypted backup of this station (wallet + ledger + config)
  restore           Restore a station from an encrypted backup archive into the data dir
  recovery          Manage key recovery: split the station key across trusted holders so a threshold of them can restore it after a lost passphrase (ADR-0016)
  status            Report the at-rest storage profile, and (encrypted profile) whether the state volume is currently unlocked. Works with the daemon stopped
  encrypt-in-place  Migrate this plaintext station to the encrypted at-rest profile: provision a member-keyed LUKS container, move the wallet and ledger inside, and split the Volume Master Key across holders (ADR-0024). Linux only. One-way — keep a backup first, and destroy the old media afterward (secure erase is unreliable on flash/SD)
  unlock            Run the boot ceremony and unlock (mount) the encrypted state volume, so the daemon can then be started (ADR-0024). Linux only. Prints a request QR and a console fingerprint for holders to confirm, then reads their responses
  vmk               Manage the Volume Master Key custody (encrypted profile, ADR-0024)
  help              Print this message or the help of the given subcommand(s)

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
  -V, --version              Print version
```

### `station init`

```text
Bootstrap a new station: generate an identity and initialize storage

Usage: station init [OPTIONS]

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

### `station run`

```text
Run the daemon (default)

Usage: station run [OPTIONS]

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

### `station peers`

```text
Inspect the static peer configuration

Usage: station peers [OPTIONS] <COMMAND>

Commands:
  list  Print the configured peers
  help  Print this message or the help of the given subcommand(s)

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

#### `station peers list`

```text
Print the configured peers

Usage: station peers list [OPTIONS]

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

### `station pair-mobile`

```text
Confirm a mobile's pairing request (T1.3.3). With no address, lists the pending requests and their confirmation codes; pass an address to confirm it after comparing the code with the mobile's screen in person

Usage: station pair-mobile [OPTIONS] [ADDRESS]

Arguments:
  [ADDRESS]  The bech32 address of the pending mobile to confirm

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

### `station list-mobiles`

```text
List the mobiles currently paired with this station

Usage: station list-mobiles [OPTIONS]

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

### `station unpair`

```text
Revoke a mobile's pairing by its bech32 address

Usage: station unpair [OPTIONS] <ADDRESS>

Arguments:
  <ADDRESS>  The mobile's bech32 address

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

### `station backup`

```text
Write an encrypted backup of this station (wallet + ledger + config).

Safe to run while the station is running: the ledger is captured as a consistent live snapshot. Prompts for the wallet passphrase, which both protects the archive and is verified before anything is written.

Usage: station backup [OPTIONS]

Options:
      --data-dir <DATA_DIR>
          Data directory (wallet, database, socket, config)

      --out <OUT>
          Where to write the archive. Defaults to a timestamped file `station-backup-<unix>.rrnbak` in the current directory

  -h, --help
          Print help (see a summary with '-h')
```

### `station restore`

```text
Restore a station from an encrypted backup archive into the data dir.

Refuses to overwrite a data dir that already holds a station unless `--force` is given. Restore into a stopped station (or a fresh dir).

Usage: station restore [OPTIONS] <ARCHIVE>

Arguments:
  <ARCHIVE>
          The backup archive to restore

Options:
      --data-dir <DATA_DIR>
          Data directory (wallet, database, socket, config)

      --force
          Overwrite even if the data dir already holds a wallet or database

  -h, --help
          Print help (see a summary with '-h')
```

### `station recovery`

```text
Manage key recovery: split the station key across trusted holders so a threshold of them can restore it after a lost passphrase (ADR-0016)

Usage: station recovery [OPTIONS] <COMMAND>

Commands:
  setup       Arm recovery: split the station key across holders and print a shard QR for each. Prompts for the wallet passphrase. Re-running re-splits and invalidates shards handed out before
  status      Show the current recovery configuration
  show-shard  Re-display one holder's shard QR (for redelivery)
  restore     Reconstruct the station key from a threshold of holders after a lost passphrase. Prints a request QR for holders to scan, then reads their responses. In place by default (data dir intact); pass a backup archive to rebuild on a fresh machine
  help        Print this message or the help of the given subcommand(s)

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

#### `station recovery setup`

```text
Arm recovery: split the station key across holders and print a shard QR for each. Prompts for the wallet passphrase. Re-running re-splits and invalidates shards handed out before

Usage: station recovery setup [OPTIONS] --holder <ADDRESS> --threshold <THRESHOLD>

Options:
      --data-dir <DATA_DIR>    Data directory (wallet, database, socket, config)
      --holder <ADDRESS>       A holder's `rrn1…` address. Repeat once per holder (N total)
      --threshold <THRESHOLD>  K — how many holders must cooperate to recover (2 ≤ K ≤ N)
  -h, --help                   Print help
```

#### `station recovery status`

```text
Show the current recovery configuration

Usage: station recovery status [OPTIONS]

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

#### `station recovery show-shard`

```text
Re-display one holder's shard QR (for redelivery)

Usage: station recovery show-shard [OPTIONS] <ADDRESS>

Arguments:
  <ADDRESS>  The holder's `rrn1…` address

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

#### `station recovery restore`

```text
Reconstruct the station key from a threshold of holders after a lost passphrase. Prints a request QR for holders to scan, then reads their responses. In place by default (data dir intact); pass a backup archive to rebuild on a fresh machine

Usage: station recovery restore [OPTIONS]

Options:
      --data-dir <DATA_DIR>    Data directory (wallet, database, socket, config)
      --from-backup <ARCHIVE>  Rebuild from this backup archive (total-loss recovery). Omit to re-key an intact data dir whose passphrase was lost
      --force                  Overwrite even if the data dir already holds a station
  -h, --help                   Print help
```

### `station status`

```text
Report the at-rest storage profile, and (encrypted profile) whether the state volume is currently unlocked. Works with the daemon stopped

Usage: station status [OPTIONS]

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

### `station encrypt-in-place`

```text
Migrate this plaintext station to the encrypted at-rest profile: provision a member-keyed LUKS container, move the wallet and ledger inside, and split the Volume Master Key across holders (ADR-0024). Linux only. One-way — keep a backup first, and destroy the old media afterward (secure erase is unreliable on flash/SD)

Usage: station encrypt-in-place [OPTIONS] --holder <ADDRESS>

Options:
      --data-dir <DATA_DIR>    Data directory (wallet, database, socket, config)
      --holder <ADDRESS>       A VMK holder's `rrn1…` address. Repeat once per holder (N total)
      --threshold <THRESHOLD>  K — how many holders must cooperate at each boot ceremony (2 ≤ K ≤ N). Defaults to the configured `[storage.encrypted] threshold` (3 if unset)
  -h, --help                   Print help
```

### `station unlock`

```text
Run the boot ceremony and unlock (mount) the encrypted state volume, so the daemon can then be started (ADR-0024). Linux only. Prints a request QR and a console fingerprint for holders to confirm, then reads their responses

Usage: station unlock [OPTIONS]

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

### `station vmk`

```text
Manage the Volume Master Key custody (encrypted profile, ADR-0024)

Usage: station vmk [OPTIONS] <COMMAND>

Commands:
  status   Show the VMK descriptor (address, K/N) and, when the volume is mounted, the current holder set
  refresh  Re-split the VMK to a new holder set. Old and new shards cannot be combined, but a full quorum of the *old* holders can still reconstruct the same key — to truly revoke, rotate the VMK (re-migrate). Runs a boot ceremony (the volume must already be unlocked) and prints the new shard QRs
  help     Print this message or the help of the given subcommand(s)

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

#### `station vmk status`

```text
Show the VMK descriptor (address, K/N) and, when the volume is mounted, the current holder set

Usage: station vmk status [OPTIONS]

Options:
      --data-dir <DATA_DIR>  Data directory (wallet, database, socket, config)
  -h, --help                 Print help
```

#### `station vmk refresh`

```text
Re-split the VMK to a new holder set. Old and new shards cannot be combined, but a full quorum of the *old* holders can still reconstruct the same key — to truly revoke, rotate the VMK (re-migrate). Runs a boot ceremony (the volume must already be unlocked) and prints the new shard QRs

Usage: station vmk refresh [OPTIONS] --holder <ADDRESS>

Options:
      --data-dir <DATA_DIR>    Data directory (wallet, database, socket, config)
      --holder <ADDRESS>       The new holder set: an `rrn1…` address, repeated once per holder
      --threshold <THRESHOLD>  The new threshold K (2 ≤ K ≤ N). Defaults to the current configured threshold when omitted
  -h, --help                   Print help
```
