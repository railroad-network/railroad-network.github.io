# Using a computer instead of a phone

Not everyone has an Android phone. A member with a laptop or desktop can hold
their own key with the **command-line wallet**, `rrn wallet`, and take part in
the community from a terminal. It is the same identity model as the phone: the
key is created on your machine and never leaves it, the station records what
you sign, and nobody can act as you without it.

> **Today this is also the most capable member device when the network is
> down.** The command-line wallet can sign payments with no station in reach,
> keep them in an outbox, print them as QR sheets for a courier, and spend
> against a headroom certificate. The phone app cannot do any of that yet: it
> needs the station reachable to send or confirm a payment. See
> [When the network is down](when-the-network-is-down.md).

## Who this is for

- A member without a smartphone, or with an iPhone (which the app does not
  support for pilots).
- A member who wants a second, offline-capable identity on a laptop. Note that
  this is a *separate* identity from a phone wallet; one key must live on
  exactly one device (below).
- Anyone who wants to rehearse the paper path before the storm.

You need to be comfortable typing commands and reading their output. Every
command is short, and `rrn wallet <command> --help` explains each one.

## Install

`rrn` is the same program the operator uses at the station console. Either the
operator hands you a copy of the binary, or you build it yourself from the
[`station`](https://github.com/railroad-network/station) repo with the Rust
toolchain from [rustup.rs](https://rustup.rs):

```sh
git clone https://github.com/railroad-network/station.git
cd station
cargo build --release -p rrn-cli
sudo cp target/release/rrn /usr/local/bin/
```

Linux and macOS are supported.

## Two settings before you start

The wallet takes its passphrase from the environment or from a hidden prompt.
It never accepts it on the command line, where it would land in your shell
history.

```sh
export RRN_WALLET_PASSPHRASE='a passphrase you choose'   # or leave unset and be prompted
export RRN_WALLET_HOME=~/.railroad/wallet                 # the default; set it to keep the wallet elsewhere
```

The wallet home directory holds your encrypted key file (`member.rrnwallet`),
a small database with your outbox and its cursors (`wallet.db`), and the
station pin. Treat the whole directory as your identity.

## Create the wallet, pinned to the station

Ask the operator for the station's `rrn1…` address, **in person**. The wallet
pins that address, and from then on every station-signed thing it accepts
(receipts, certificates, the pairing reply) is checked against the pin. That
hand-off is this path's security boundary, exactly as the pairing-code
comparison is for a phone. Read it off the operator's screen; do not accept it
over email.

```sh
rrn wallet init --station rrn1<the-station-address>
```

This prints your own new `rrn1…` address. Write it down; you will read it to
people who want to pay you or vouch for you.

## Pair, then sync

Pairing is the same short ceremony a phone goes through, over the same sealed
channel. Be on the station's network and next to the operator:

```sh
rrn wallet pair --url 192.168.4.1:7500     # the station's address and port, from the operator
```

The wallet prints an **8-character code**. The operator sees a code beside your
address in their list of pending requests. Compare them aloud. If they match,
the operator confirms your address and the wallet is paired. If they do not
match, stop: something on the network answered in the station's place.

Then:

```sh
rrn wallet sync
```

Sync pulls your nonce, the position of your outbox as the station knows it,
your balance, and any delivery receipts waiting for you. Run it whenever you
are back in range. **It is mandatory after any restore or recovery** (see
below), because a wallet that does not know how far its own history got would
sign a record the station reads as a forked identity.

## Everyday use

| You want to | Command |
| --- | --- |
| See your address, pairing, and how many records are pending | `rrn wallet status` (never unlocks the key) |
| Pay someone | `rrn wallet pay rrn1<receiver> 3.50 --memo "eggs"` |
| Confirm a payment addressed to you | `rrn wallet confirm <tx-id>` |
| Vote on a proposal | `rrn wallet vote <proposal-id> yes` (or `no`, `abstain`) |
| Contest a confirmed payment | `rrn wallet dispute <tx-id> --reason "…"` |
| Vouch for someone | `rrn wallet vouch rrn1<address> --statement "…" --stake <amount>` |
| Your transactions, live from the station | `rrn wallet transactions` |
| Your local outbox and what happened to each record | `rrn wallet show` (add `--all` for history) |

Every signing command chains the record into your **outbox**. Nothing reaches
the station until it is submitted or carried there, so the normal online rhythm
is: sign, then

```sh
rrn wallet submit
```

which bundles everything pending, sends it over the channel, and applies the
station's receipts in one go. `transactions` and `sync` read live, so they
need the station reachable. Vouching is **online only**: it is one of the few
things you cannot queue up offline.

Amounts are written in Commons (`3`, `3.5`, `3.50`). The debt floor, settlement
windows, and tiers work exactly as they do for a phone; see
[Pay and get paid](pay-and-get-paid.md).

## The offline loop

When the station is out of reach, sign anyway. A record signed today and
delivered next week is admitted next week; its settlement window starts when
it arrives.

```sh
# Sign. --carrier slow gives the record a two-week validity window instead of
# the normal 24 hours, so it survives a slow delivery.
rrn wallet pay rrn1<receiver> 4.00 --memo "firewood" --carrier slow

# Export what is pending, either as printable QR sheets ...
rrn wallet export qr --out ~/to-carry/
#   -> chunk_NN_of_MM.png, a captioned sheet.pdf, and bundle.txt (the raw lines)

# ... or as one raw file for a radio or USB stick.
rrn wallet export bundle --out ~/to-carry/
#   -> payload.bundle, for the operator's `rrn dtn push --bundle`
```

Hand the sheet or the file to a **courier**: anyone walking to the station.
They need no trust. Every record is signed by you and re-checked by the
station; a courier can lose or delay it, never alter it. Re-exporting and
sending the same records twice is always safe.

At the station, the operator ingests the sheet at the
[courier desk](../operators/courier-desk.md) and prints your **delivery
receipts** for the return trip. When they reach you:

```sh
rrn wallet receipts apply --in ~/carried-back/receipts.txt
```

Each receipt says whether the record was admitted, was already known, or was
refused and why. Until a receipt arrives, the record stays pending in
`rrn wallet show`. A receipt is proof; the absence of one is not proof of
anything, so keep re-sending until it comes back.

If you come back into Wi-Fi range before the courier does, just run
`rrn wallet submit`: the station recognizes anything it already has.

## Headroom certificates

A receiver who cannot reach the station cannot see your balance, so they
cannot know an offline payment will clear your debt floor. A **headroom
certificate** reserves part of your credit while you are still connected, so a
later offline payment against it is accepted on arrival. The idea is explained
in [When the network is down](when-the-network-is-down.md#before-the-storm-headroom-certificates).

```sh
rrn wallet cert request 10          # reserve 10 Commons of headroom (needs the station)
rrn wallet cert list                # what you hold, with caps and expiries
rrn wallet pay rrn1<receiver> 6.00 --cert <cert-id-or-prefix> --carrier slow \
    --voucher-out ~/to-carry/       # also writes rrnspend: lines the receiver can verify offline
rrn wallet cert return <cert-id>    # give back what you did not use (a chained record, carried like any other)
rrn wallet cert import --in card.txt   # load a certificate from an rrncert: line, for instance a printed card
```

Reserved headroom is idle headroom: a 10-Common certificate is 10 Commons you
cannot spend online until it expires or you return it. Reserve before a market
day or a trip; return the remainder when you are back.

> **Never spend one certificate twice.** The station will refuse the second
> spend when both arrive and record the double-spend as provable equivocation.
> Your standing drops to nothing and a jury case opens. This is the one fraud
> the system cannot prevent offline, only price.

## Back up the whole directory

Back up the **entire wallet home directory**, not just the key file. The
outbox and its position live beside the key, and a backup of the key alone
loses the chain. Full-disk encryption on the laptop is your responsibility: the
key file is encrypted under your passphrase, but the decrypted key is in memory
while a command runs.

To restore on a new machine:

```sh
rrn wallet init --station rrn1<the-station-address> --restore member.rrnwallet
rrn wallet sync                       # required before the wallet will sign anything
```

A wallet exported from the phone app restores the same way; see
[Back up and recover your keys](keep-your-keys-safe.md#restoring-from-an-export).

**One key, one device.** Do not copy a wallet directory to a second machine
and sign from both. Two records at the same outbox position are equivocation,
with the same consequence as a double-spent certificate, and the software
cannot stop a determined member from doing it to themselves.

## Recover a lost key from your circle

If you set up a recovery circle on your phone and then lost the phone, you can
rebuild the key on a laptop. Gather at least three of your holders in person:

```sh
rrn wallet recover --station rrn1<the-station-address> --address rrn1<your-old-address>
```

The command prints a **request QR** and a short **ceremony fingerprint**. Read
the fingerprint aloud; each holder must see the same one on their screen before
they answer, which is what stops someone with a stolen request from tricking
your holders. Each holder scans the request in the app under **Shards you hold
→ Help someone recover** and shows you a response QR; paste each response line
into the waiting command. When enough are in, the key is rebuilt on your
machine. Nothing touches the station.

The recovered wallet is treated as restored: it refuses to sign until one
`rrn wallet sync` re-anchors it. The full member-side story is in
[Back up and recover your keys](keep-your-keys-safe.md).

## What the command-line wallet does not do yet

- **No recovery circle of its own.** The wallet can *rebuild* a key from a
  circle that was set up on a phone, but it cannot yet split its own key and
  hand out shards. Until it can, keep the directory backup current; that is
  this wallet's only self-made safety net. The decision record that scoped the
  wallet lists this as follow-on work.
- **No marketplace, and no proposal authoring.** The member verbs are pay,
  confirm, vote, dispute, and vouch. Listings, inquiries, contracts, and
  authoring or co-signing proposals are in the app, or in the operator's
  console commands for the station's own wallet.
- **No jury duty.** If you are drawn as a juror, there is no wallet command to
  rule with yet.
- **One device per key**, as above.

The wallet is specified by
[ADR-0028](https://github.com/railroad-network/station/blob/main/docs/adr/0028-non-mobile-member-wallet.md),
which extends the "the member device holds the keys" rule of
[ADR-0006](https://github.com/railroad-network/station/blob/main/docs/adr/0006-m1-client-architecture.md)
from phones to computers. The
[`rrn` command reference](../reference/cli/rrn.md#rrn-wallet) lists every
option.
