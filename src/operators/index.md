# What an operator does

The **operator** keeps the community's station running. The station is an
ordinary computer, often a Raspberry Pi, that holds the community's ledger and
is the one thing that writes to it. Phones talk to it over the local network.
If it is down, members keep signing but nothing settles until it is back.

The job in one sentence: **keep it running, keep it backed up, and keep the
pairing ceremony honest.**

## What you need

| Thing | Details |
| --- | --- |
| A machine | Any always-on Linux or macOS box: a Raspberry Pi 4 or 5 with a 64-bit OS and 4 GB or more of RAM, a spare laptop, a mini-PC. |
| A network | A Wi-Fi network all members' phones can join. Give the station a fixed address on it if you can. |
| The software | Built from source, once. Ten to thirty minutes. |
| Two safe places | For the passphrase and backups. A fireproof folder at home plus a sealed envelope with a trusted member. |

## The pages

1. [Run a station](run-a-station.md): build, initialize, configure, run,
   survive reboots.
2. [Pair phones and wallets](pair-phones-and-wallets.md): the in-person
   ceremony that is the actual security boundary.
3. [Backups and key recovery](backups-and-key-recovery.md): the fifteen
   minutes that save the community.
4. Encrypted at rest *(planned)*: the seizure-resistant profile, Linux only.
5. The courier desk *(planned)*: ingesting paper, printing receipts and cards.
6. Radio and text message *(planned)*: LoRa bring-up and the SMS seam.
7. Keeping phones in sync *(planned)*: the per-vendor battery traps.
8. Troubleshooting *(planned)*.

Until the planned pages land, the full operator runbooks live in the `station`
repo and are complete:

- [Setting up a Railroad Network community](https://github.com/railroad-network/station/blob/main/docs/community-setup.md):
  the end-to-end runbook, including seizure resistance, paper, radio, and the
  outage drill.
- [Keeping phones in sync when the app is closed](https://github.com/railroad-network/station/blob/main/docs/background-reliability.md).
- [Bringing up a LoRa radio link](https://github.com/railroad-network/station/blob/main/docs/lora-radio-bringup.md).

## Honest warnings

- **Research-stage software.** No independent audit. Play stakes only.
- **One station, one network.** No federation and no relaying over the
  internet yet. Your community is one station plus the phones that can reach
  it.
- **Phone traffic is plain HTTP, on purpose.** Every message is encrypted and
  signed end to end, so the transport needs no TLS. The security ceremony that
  matters is the pairing-code comparison. Take it seriously.
- **Android only, sideloaded.** You hand members a signed installer file.
