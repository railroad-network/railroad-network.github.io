# Pair phones and wallets

Pairing is a short in-person ceremony between a member and you. It proves to
the phone that it is talking to the real station, and to the station that
this phone is welcome. **The code comparison is the actual security boundary**
of the whole system, so do it face to face, reading the code aloud.

## A phone

**On the phone.** After creating a wallet, the member taps **Join your
community**. The station appears by name, or they tap *Add by address* and
type the station's IP and port 7500. They unlock; the phone shows an
**8-character code**.

**On the station:**

```sh
station pair-mobile
```

lists the pending requests, each with a code and the phone's `rrn1…` address.

**Together.** Compare the code on the phone with the one the station printed.
If, and only if, they match:

```sh
station pair-mobile <the-phone's-rrn1-address>
```

and the member confirms on their phone. The phone now syncs, receives push
updates, and can transact.

> **If the codes do not match, refuse.** Something on the network answered in
> the station's place. Find out what before pairing anyone.

Housekeeping over the community's life:

```sh
station list-mobiles          # who is paired
station unpair <rrn1-addr>    # revoke a lost or departed member's phone
```

## A computer instead of a phone

A member with a laptop and no Android phone can hold their own key with the
built-in `rrn wallet`. Same identity model, driven from a terminal, works
offline.

**They learn the station's address from you, in person.** The wallet pins
that address, and every station-signed thing it later accepts is checked
against the pin. That hand-off is this path's security boundary, exactly as
the code comparison is for a phone. Read the address to them; do not email it.

On the member's laptop:

```sh
export RRN_WALLET_PASSPHRASE='something the member chooses'   # never on a command line
rrn wallet init  --station rrn1<your-station-address>          # prints their new rrn1… address
rrn wallet pair  --url 192.168.4.1:7500                        # shows an 8-character code
```

Confirm the pair exactly as for a phone: compare the code the wallet prints
with what `station pair-mobile` lists, then confirm their address. The member
then runs `rrn wallet sync` to pull their nonce, balance, and receipts.

Two things the member must understand:

- **Back up the whole wallet directory** (`~/.railroad/wallet` by default),
  not just the key file. The outbox and its cursors live beside the key.
- **Full-disk encryption is their responsibility.** The wallet encrypts its
  key file, but the decrypted key is in memory while a command runs.

After restoring from a backup they must reach the station once and sync before
signing again, so their chain cannot fork.

## After pairing

Nudge every member through two things in the first week: **Export wallet**
(Settings), and the recovery circle once there are a few members to hand
shards to. Today only the export can actually restore a member's key; see
[Back up and recover your keys](../members/keep-your-keys-safe.md). A lost
phone without either is a lost identity, and helping members avoid that is
operator work too.
