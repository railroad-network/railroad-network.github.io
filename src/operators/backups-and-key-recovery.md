# Backups and key recovery

The station directory holds the only copy of your community's history and the
key that is its identity. Three failures will eventually visit any
long-running community: the machine dies, the passphrase is lost, or both at
once. Each has a prepared exit, but only if you prepare it **before** the
failure. Both preparations together take about fifteen minutes. Do them the
day you found the community.

## Backups

```sh
station backup
```

Safe to run while the station is serving. It verifies your passphrase, then
writes a single **encrypted** archive, `station-backup-<timestamp>.rrnbak`,
bundling the wallet, the ledger, the paired-phones list, and the config. Use
`--out` to choose where.

Because the archive is encrypted it is safe to copy anywhere: a USB stick in a
drawer, another machine, a cloud drive. What is not safe is keeping the only
copy on the station itself.

A pilot-grade routine:

- **Weekly**, and before any software upgrade, run a backup and copy it off
  the machine.
- **Keep the last three or four**, not just the newest.
- **Rehearse the restore once, early**, into a scratch directory, so you know
  it works and the passphrase does too:

  ```sh
  station restore station-backup-<timestamp>.rrnbak --data-dir /tmp/restore-drill
  rm -rf /tmp/restore-drill
  ```

To restore for real after losing a machine: build the software on the new
machine, then

```sh
station restore <archive>
station run
```

Restore refuses to overwrite an existing station unless you add `--force`. It
restores everything, pairings included, so members' phones simply resume. The
ledger resumes from the snapshot: anything transacted after your last backup
is gone. That is why the routine is weekly.

## Key recovery

A backup you cannot decrypt is a paperweight, and the archive is rightly
encrypted under the passphrase. So the station also supports **social key
recovery**: its key is split into shards sealed to trusted members' phones. A
threshold of them, cooperating in person, can reconstruct the key, which also
unlocks any backup archive, passphrase or no passphrase.

**Arm it** as soon as you have a few paired members you trust:

```sh
station recovery setup \
  --threshold 3 \
  --holder <alice-rrn1-address> \
  --holder <bob-rrn1-address> \
  --holder <carol-rrn1-address> \
  --holder <dan-rrn1-address> \
  --holder <erin-rrn1-address>
```

**3 of 5** is the sweet spot for a small community: no single holder or pair
can act alone, and losing one or two does not sink you. Holders must be paired
members. Pick people unlikely to leave together.

The command prints a **QR code per holder**. Each holder scans theirs, in
person, in the app under **Settings → Shards you hold**. The shard sits on
their phone doing nothing, possibly for years. If a holder leaves, re-run
setup with a new roster; a re-run re-splits the key and invalidates every
earlier shard.

```sh
station recovery status              # the current roster
station recovery show-shard <addr>   # re-display one holder's QR
```

**Use it** the day the passphrase is gone. Gather a threshold of holders in
one room:

```sh
station recovery restore                          # passphrase lost, data dir intact
station recovery restore --from-backup <archive>  # machine AND passphrase lost
```

The command prints a **request QR**. Each holder opens **Shards you hold →
Help someone recover**, scans it, checks the station address shown is really
yours, unlocks with their own passphrase, and their phone shows a **response
QR**. Scan each response and paste the `rrnrecover-resp:…` lines into the
waiting command. With enough responses in, you choose a new passphrase and
the station is yours again. **Take a fresh backup immediately**: the old
archives still answer only to the old key wrapping.

## The disaster table

| What happened | What saves you | Prepared by |
| --- | --- | --- |
| Station machine dies | `station restore <archive>` on a new machine | Backups |
| Passphrase lost, machine fine | `station recovery restore` | Key recovery |
| Machine dies **and** passphrase lost | `station recovery restore --from-backup <archive>` | Both |
| A member loses their phone | Their own social recovery, held by friends | Each member, in-app |
| A member's phone is stolen | `station unpair <addr>`, then the member recovers on a new phone | Nothing to prepare |

The first three rows protect the community. The last two protect a member,
which is why nudging everyone through in-app social recovery is operator work
too.

## Seizure resistance

For communities under surveillance pressure there is an optional **encrypted
at-rest profile** on Linux: the wallet and ledger live inside an encrypted
volume whose key is itself split among member-held shards, and the station
cannot boot without a quorum of holders present. It is one-way, needs
practice, and has its own page coming. Until then, the runbook's
[seizure resistance section](https://github.com/railroad-network/station/blob/main/docs/community-setup.md#44-seizure-resistance--the-encrypted-profile-optional-linux)
is complete.
