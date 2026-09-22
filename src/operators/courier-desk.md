# The courier desk

When a member cannot reach the station by any network, a payment can still
travel on **paper**. The member signs a record on their own device, turns it
into QR codes, and someone carries the printed sheet to the station. The
station scans it in, checks it, and hands back a signed receipt for the return
trip. This page is the operator's side of that loop: the desk where sheets
arrive and receipts go out.

> **Who this serves today.** The phone app cannot yet export its outbox or
> accept a payment offline: it needs the station in reach to send or confirm.
> The plumbing for it exists in the app's Rust core, but the screens do not.
> The members whose records a courier carries are therefore those using the
> [command-line wallet](../members/using-a-computer.md), which signs offline,
> prints its own outbox, and applies receipts. The tools on this page work the
> same way for either once the app catches up.

## What a courier carries

A **courier** is anyone who physically moves records between a cut-off member
and the station: a neighbour walking to the community hall, the person who
drives to town, a bicycle. There are three kinds of thing in their pocket.

- **A bundle**, going *to* the station. One or more members' signed records:
  payments, confirmations, ballots, disputes. On paper it is a sheet of
  numbered QR codes. On a USB stick it is a single file.
- **Delivery receipts**, going *back* to each author. The station's signed
  answer, per record: admitted, already known, or refused and why.
- **Cards**, printed once and carried by their owner: a member's address as a
  credential card, or a headroom certificate as a wallet card.

**A courier needs no trust.** Every record is signed by its author and the
station re-checks every signature. A courier can lose, delay, or duplicate
what they carry. They cannot forge or alter it. A sheet holds no secret: losing
one is a delay, never a loss of funds. This is the whole design of the offline
path, locked in
[ADR-0020](https://github.com/railroad-network/station/blob/main/docs/adr/0020-single-writer-log-dtn-submission.md).

## What you need at the desk

- **A printer.** Any monochrome laser is plenty.
- **A QR scanner app**, on any phone, or a webcam scanning tool. The `rrn`
  command line does **not** read camera images: a headless station has no
  camera. Scanning produces *text*, one QR payload string per line, saved to a
  file. That file is what you feed the station.

A payload string starts with a short prefix that says what it is: `rrnp:` for
one chunk of a multi-part sheet, `rrncert:` for a certificate, `rrnspend:`
for an offline spend voucher, and a bare `rrn1…` for an address. The formats
are pinned in the
[QR payload spec](https://github.com/railroad-network/station/blob/main/docs/spec/qr-payloads.md).

## A sheet arrives

Scan every QR on the sheet into a text file, one line each, in any order.
Then:

```sh
# Look before you ingest. Works with the daemon stopped.
rrn paper show --in scanned.txt

# Ingest: reassemble, submit to the station, print each record's outcome,
# and write the receipts for the return trip.
rrn paper ingest --in scanned.txt --out carryback/
```

`show` classifies every payload, verifies every signature it can, and reports
which chunks are missing from an incomplete group. Use it when a sheet looks
damaged or a courier is unsure what they were handed.

`ingest` prints one line per carried record with its outcome:

| Outcome | Meaning |
| --- | --- |
| **admitted** | New, valid, now on the log. The settlement window starts from this moment. |
| **known** | The station had it already, from an earlier sheet or another route. Nothing double-counted. |
| **refused** | Rejected, with a reason. The record never touched the log. |

**Re-ingesting is always safe.** Scan the same sheet twice, or receive the
same bundle from two couriers, and the station recognises it and returns the
same receipt. Nothing is admitted twice.

Every sheet's QR codes are labelled with the payload's short id and their
index, `3 of 7`, so a dropped page can be spotted by eye. Chunks of two
different payloads mixed together are refused as a group rather than combined
into nonsense, and a clean re-scan rebuilds the set.

### Reading a refusal

The commonest reasons, and what to tell the courier to tell the member:

| Reason | What it means | What to do |
| --- | --- | --- |
| `nonce-gap` | An earlier record from this member has not arrived yet. Records from one device form a chain and land in order. | Wait. The earlier one is on its way, or was lost and needs re-sending. Re-ingest this sheet afterwards. |
| `debt-floor` | The payment would have taken the payer below the debt floor, and no headroom certificate backed it. | The payer needs a certificate before going offline next time. See below. |
| `bad-signature` | The bytes do not match the signature: a scan error, a corrupted line, or tampering. | Re-scan. If it persists, the sheet is not what the member printed. |
| `cert-expired`, `cert-overspent`, `cert-unknown`, `cert-wrong-member` | A certificate-backed spend failed one of its checks. | The receiver should have caught most of these when they accepted the payment. An overspend is recorded as equivocation, which costs the payer their whole standing. |
| `read-replica` | You are at a replica, not the community's writer. | Carry the sheet to the writer station. A replica admits nothing. |

## Receipts go back

The station holds a signed receipt for every record it has processed until the
author's own device confirms it has seen it. Sending them home:

```sh
# Receipts for a member who is about to walk home:
rrn paper export-receipts --author rrn1<member> --out receipts/

# Or the whole pending queue, for a courier doing the rounds:
rrn paper export-receipts --out receipts/
```

Exporting never marks a receipt delivered. Only the author's device does that,
when it applies the receipt. So it is safe to export the same receipts twice,
and if a receipt sheet goes missing, run the export again.

> **Tip.** Tell members the rule plainly: **a receipt is proof; the absence of
> a receipt is proof of nothing.** A member whose device has not seen a receipt
> should keep re-sending. Re-sending is always safe.

## Cards

Two things are printed once and kept:

```sh
# A member's credential card: their address as a QR, with a name on it.
rrn paper credential --address rrn1<member> --name "Jordan" --out cards/

# A headroom certificate as a wallet card, for the station's own wallet.
rrn paper cert --request 10 --out cards/        # reserve 10 Commons and print it
rrn paper cert --cert-id <hex> --out cards/     # print an existing live one
```

A **credential card** is just the member's address. It is how a courier or a
merchant scans a payee without typing a long string, and how a member reads
their own address off paper when rebuilding a lost key.

A **headroom certificate** is the station's signed reservation of part of a
member's credit headroom, made while connected so that a later offline payment
against it is accepted on arrival. The card carries the certificate as a
single QR with the member, the cap, and the expiry printed beneath. The
station's own wallet requests one with `rrn cert request`; a member on the
command-line wallet requests theirs with `rrn wallet cert request` and can
import a printed one with `rrn wallet cert import`. The rules are in
[When the network is down](../members/when-the-network-is-down.md) and locked
in [ADR-0021](https://github.com/railroad-network/station/blob/main/docs/adr/0021-escrowed-offline-spending-certificates.md).

## What is in an output directory

Every `--out` directory gets the same three things:

| File | What it is |
| --- | --- |
| `chunk_NN_of_MM.png` | One PNG per QR code, numbered. |
| `sheet.pdf` | Every QR on captioned pages: payload id, index, and count under each one. Print this. |
| `*.txt` | The raw payload strings, one per line. The no-printer path: copy this file to a USB stick instead, or read it back with `rrn paper render`. |

`rrn paper render --in some.txt --out sheets/` turns any saved text file back
into a printable sheet. It is the primitive the other commands use.

## Limits worth knowing

- A paper payload is at most 64 chunks. In practice that is around a hundred
  small records per sheet set. A larger bundle is electronic-only: a USB stick
  or a [radio](radio-and-sms.md).
- A payment signed for a slow carrier should carry a long validity window. The
  command-line wallet's `--carrier slow` sets two weeks instead of one day, so
  the record survives the trip.
- A certificate-backed spend can arrive up to fourteen days after the
  certificate expires and still be admitted, so a courier who is late does not
  strand the receiver.

## The routine

At a market day or during an outage, the desk runs like this:

1. Couriers arrive with sheets. `show`, then `ingest`, then read the outcomes
   aloud to the courier.
2. Before each courier leaves, `export-receipts` for the members they are
   heading back toward, and print the sheet.
3. Members who reach Wi-Fi again pick up their receipts themselves; the paper
   ones are for those who will not.
4. Keep the `carryback/` directories. They are proof of what left the desk.

The end-to-end walkthrough, with real binaries and a simulated phone, is the
`demo-phase-2-paper.sh` script in the `station` repo. The same loop with a
laptop member is `demo-phase-2-wallet.sh`.
