# Encrypted at rest

By default a station keeps its database in the clear. Only the station's own
key is encrypted, under the passphrase you typed at `station init`. A
powered-off station that is seized or imaged therefore hands over the whole
community: every balance, every memo, and who vouched for whom.

For communities that face that threat there is an optional **encrypted at-rest
profile**. The ledger, the station's wallet, the paired-phones list, the search
index, and the radio identity all live inside an encrypted container whose key
is **held by members, not stored on the machine**. Powered off, the station is
an encrypted brick: no key on disk, no list of who holds the pieces.

This page is the operator's walkthrough. The design and its trade-offs are
locked in
[ADR-0024](https://github.com/railroad-network/station/blob/main/docs/adr/0024-station-at-rest-encryption-key-ceremony.md).

## What it protects, and what it does not

**Protected:** a station that is off, or whose storage is copied while off. The
container has no key slot at all. The key is rebuilt, each time, from shards
held by a quorum of members, and it lives only in kernel memory while the
station runs.

**Not protected:** a station seized **while running**. The volume is mounted
and the key is in memory. Live imaging or a cold-boot attack can recover it.
The defenses there are physical: custody of the machine, a tamper-evident
enclosure, and a fast rebuild on new hardware from your backups. The profile
does not claim to defend a running node.

Also not protected: anything the host leaks around the container. Swap, crash
dumps, and logs written to a plaintext partition can carry pieces of the key or
of the ledger. The hardening steps below are not optional.

## The trade you are choosing

Every loss of power makes the station a locked brick until enough key holders
gather to run an unlock ceremony. A blackout, a tripped breaker, an unplugged
cable, a reboot for an update: each one needs a ceremony. Where holders share a
building that is minutes. Where they are dispersed it can mean a scheduled
meetup, and days of downtime. During that time members keep signing, but
nothing settles.

So:

- **A UPS is close to mandatory.** It turns brownouts and blips, the common
  cause of downtime, into non-events, and shuts the station down cleanly when
  the battery runs low.
- **There is no operator-passphrase shortcut.** A passphrase one person knows
  is exactly what coercion extracts. The member-held quorum exists to remove
  that single seizable human. If you want a single-operator unlock, you want
  the plaintext profile. Use it honestly.
- **Linux only.** The profile uses the kernel's own disk encryption. A station
  configured for it on macOS refuses to start rather than quietly serving
  plaintext.

## Before you turn it on

**Harden the host.** The encryption is only as good as the machine around it.

```sh
# Disable swap (or use encrypted swap) so key bytes and database pages never page out:
sudo swapoff -a          # and remove the swap entry from /etc/fstab

# Suppress core dumps so a crash cannot spill plaintext to disk:
echo 'kernel.core_pattern=|/bin/false' | sudo tee /etc/sysctl.d/50-no-cores.conf

# Keep logs off any plaintext partition (journald to volatile storage is fine).
```

**Give the station user a scoped privilege.** Provisioning and unlocking drive
the kernel's disk tools through `sudo` without a password. The daemon itself
stays unprivileged. If the station runs as a dedicated user, grant that user
exactly those tools and nothing else:

```
# /etc/sudoers.d/rrn-station  (edit with: visudo -f), for user "rrn":
rrn ALL=(root) NOPASSWD: /usr/sbin/cryptsetup, /usr/sbin/losetup, /bin/mount, \
    /bin/umount, /sbin/mkfs.ext4, /bin/chown
```

> **Warning.** Granting `mount`, `chown`, and `cryptsetup` to a user is close to
> root on that host. That is the price of a scripted, testable key ceremony. A
> community that wants a smaller privileged surface can run the ceremonies as
> root, interactively, instead of through a service account.

**Take a backup.** The migration is one-way. See
[Backups and key recovery](backups-and-key-recovery.md).

## Turn it on: the one-way migration

You need each key holder's `rrn1…` address. Holders read it from their own
app under Settings → Your address. Three of five is the usual shape, for the
same reasons as station key recovery: no single holder or pair can act alone,
and losing one or two does not sink you.

```sh
station backup --out ~/before-encrypt.rrnbak        # keep this somewhere safe

station encrypt-in-place \
    --holder rrn1<alice> --holder rrn1<bob> --holder rrn1<carol> \
    --holder rrn1<dave>  --holder rrn1<erin> \
    --threshold 3
```

The command provisions the container, moves the wallet and ledger inside,
splits the volume key three-of-five, and prints **one QR code per holder**. The
volume is left unlocked so you can `station run` straight away.

Have each holder scan their QR **in person**, in the app under Settings →
**Shards you hold**. Their phone stores it as an ordinary recovery shard. It
reads as "a shard for `rrn1…`", naming the volume key's address rather than
the station's. That is expected.

The holder set is deliberately **not** written to the configuration file. A
seized card must not carry a list of whom to pressure. The authoritative record
of who holds a shard lives inside the container and is readable only once it is
unlocked, with `station vmk status`.

**Then destroy the old media.** The migration securely erases the plaintext
files it moved, but secure erase is unreliable on SD cards and other flash: old
blocks can survive wear levelling. For a real threat model, physically destroy
the card the station ran on before the migration and start the encrypted
station on a fresh one.

## Every boot from now on: the unlock ceremony

After any power loss the station will not start until a quorum of holders
help.

```sh
station status          # "state volume: LOCKED (not mounted)"
station unlock          # prints a request QR and a short console fingerprint
station run             # once the volume is mounted, the daemon starts normally
```

The ceremony, step by step:

1. `station unlock` shows a **request QR** and a **console fingerprint**, two
   groups of five letters such as `B523J-DY6LH`.
2. **Read the fingerprint aloud** to each holder, or send it over a channel you
   both trust.
3. Each holder opens Settings → Shards you hold → **Help someone recover**,
   scans the request, and compares the fingerprint their phone shows with the
   one you read. **Only if they match** do they enter their passphrase and
   show you the response QR.
4. Scan each response and paste the `rrnrecover-resp:…` lines into the waiting
   command. When enough are in, the volume mounts.

The fingerprint is the whole safety check. Before the volume is unlocked the
station has no key of its own, so the request cannot be signed. Someone who
copied the machine and ran their own ceremony would show a **different**
fingerprint, and the holders would catch it. If a holder's fingerprint does
not match yours, **stop**. Someone else is running a ceremony against your
holders. The algorithm is pinned in the
[boot ceremony spec](https://github.com/railroad-network/station/blob/main/docs/spec/vmk-boot-ceremony.md)
so the app and the station always agree.

> **Tip.** Holders can answer remotely if they must. A response is sealed to
> this one ceremony and is useless to anyone else. What cannot be skipped is
> the fingerprint comparison, which is the only thing telling a remote holder
> that the request really came from you.

### Running under systemd

Under the encrypted profile `station run` exits until the volume is unlocked.
A unit with `Restart=always` crash-loops after every reboot until someone runs
the ceremony. That is expected: unlock is a deliberate human step. Use
`Restart=on-failure`, as the sample unit in [Run a station](run-a-station.md)
does, and either start the service after the ceremony or leave it enabled and
accept the restart backoff until the holders have gathered.

## Rotating holders

When a relationship changes, re-split the key to a new set. The volume must be
unlocked first.

```sh
station vmk status                                   # current holders, K of N
station vmk refresh --holder … --holder … --threshold 3
```

A refresh gives every holder a brand-new shard, and old and new shards cannot
be mixed: a leftover old shard is useless next to the new ones. It does **not**
change the underlying volume key, though. A full quorum of the *former*
holders, acting together, could still rebuild it.

To lock former holders out completely, rotate onto a **new** container. The
migration command refuses to run on a station that is already encrypted, so a
rotation is a fresh migration:

```sh
station unlock && station backup --out rotate.rrnbak     # while still unlocked
station restore rotate.rrnbak --data-dir /path/to/fresh  # a fresh, plaintext dir
station --data-dir /path/to/fresh encrypt-in-place \
    --holder … --holder … --threshold 3                  # new holders, new key
cp <old-boot-dir>/config.toml /path/to/fresh/            # backups omit the boot config
```

Move the fresh directory into place and, again, physically destroy the old
media: the restore step rewrote the plaintext ledger onto it.

## Backups under this profile

`station backup` still works while the station is serving, and the archive
still covers everything inside the container: ledger, wallet, pairings. It does
**not** cover the unencrypted boot directory's `config.toml`, which holds your
listen addresses, timers, and radio settings. Keep a copy of `config.toml`
alongside your backups, or expect to re-enter that configuration when you
restore onto fresh hardware. The keys are documented in the
[configuration reference](../reference/configuration.md).

Recovering an encrypted station onto new hardware is a manual sequence:
`station restore <archive>` to get the ledger and wallet back, then
`station encrypt-in-place` to provision a new container and re-arm the volume
key to your holders, then the unlock ceremony.

## The drills

Two things only work if practised, and neither failure is cryptographic. The
failure is three holders who cannot be found, or who have never scanned a
request before.

| Drill | How often | Command |
| --- | --- | --- |
| The unlock ceremony, with the real holders | After arming, after every holder change, at least twice a year | `station unlock` |
| The community-continues path: restore from backup on fresh storage | Quarterly, and before any upgrade | `scripts/drill-seizure-recovery.sh --profile plaintext` |
| The brick property: a closed container leaks nothing | After arming and after every re-key | `scripts/drill-seizure-recovery.sh --profile encrypted` |
| The UPS | Monthly: pull the mains, confirm a clean shutdown on low battery | none |

The `encrypted` drill plants a marker inside the volume, closes it, and proves
the marker appears nowhere in the container bytes or the boot directory, that
the holder set is absent from the boot directory, and that the container has
zero key slots. The `plaintext` drill runs on any machine and rehearses the
restore path end to end. Both scripts ship in the `station` repo.

Practising the ceremony is part of the community's
[outage drill](../organizers/outage-drill.md).
