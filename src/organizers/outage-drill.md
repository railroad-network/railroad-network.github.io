# Running an outage drill

The software's version of a 72-hour outage runs in seconds, in a test that
stands up a real station and about twenty simulated members, cuts the network,
trades over couriers, paper, and a lossy radio model for three simulated days,
and checks that everything reconciles. The community's version takes a
half-day and real people, and it is the only way to learn where *your*
community actually breaks: which holders cannot be found, which courier gets
lost, which merchant will not take an offline payment. Run it before you need
it. This page is for the person facilitating.

> **What the phones can and cannot do today.** The runbook this drill comes
> from assumes members sign offline on their phones. The phone app cannot do
> that yet: it needs the station reachable to send or confirm a payment, and it
> has no outbox, no certificates, and no paper export. The only member device
> that does all of that is the
> [command-line wallet](../members/using-a-computer.md) on a laptop. So during
> the cut, offline trade happens on laptops and on paper at the
> [courier desk](../operators/courier-desk.md), and phone members play the
> part of the people who were out of range and come back when the network
> does. That is still most of the drill, and it is an honest picture of a
> pilot today.

## Why drill

The mechanisms that carry a community through an outage are all things people
do: reserve a certificate before the storm, carry a sheet to the steward,
confirm a fingerprint out loud, keep re-sending until the receipt comes back.
None of them is exercised by ordinary trading on Wi-Fi. A drill is the only
time they get practised, and the debrief is where the community writes down
what surprised it.

## What you need

- The station on a UPS or battery, backed up that morning (`station backup`).
- A printer and a phone with any QR-scanner app, at the courier desk.
- At least one or two members with `rrn wallet` on a laptop, set up and paired
  **before** the day. Two is better: they can pay each other.
- Optionally a LoRa pair, if the community has brought radios up.
- Paper and pens for the log sheet.
- About 8 to 20 members and four hours.
- Play stakes. This is pilot software.

If you shorten the settlement window for the drill so settlements land the
same afternoon, do it in the station's configuration beforehand and put it
back afterwards; see [Configuration](../reference/configuration.md).

## Roles

Assign before the day:

| Role | Does |
| --- | --- |
| **Facilitator** | Runs the clock, calls the phases, keeps the log sheet. |
| **Steward** | At the station console the whole time: ingest, export receipts, status. Usually the operator. |
| **Two couriers** | One on foot; one "slow", who deliberately delays and reorders what they carry. |
| **Laptop members** | One or two people with the command-line wallet. They are the offline economy. |
| **A merchant and a customer or two** | Trade for real, with real goods. Lunch works. |
| **A holder quorum** | If the station runs the encrypted profile, the key-holders who unlock it. |
| **One adversary** | Briefed privately; see below. |
| **Everyone else** | Phone members who transact while online, vote, watch the banners, and try to break things. |

## Timeline

| Time | Phase | What happens |
| --- | --- | --- |
| Day before | Prepare | Laptop members reserve a headroom certificate (`rrn wallet cert request`) while online. The steward prints credential cards for anyone who wants one and a certificate card for the station's own wallet. The facilitator briefs the adversary. |
| 0:00 | Normal | Fifteen minutes of ordinary trade on Wi-Fi, phones included. The steward notes a few balances and the length of the log. |
| 0:15 | **Cut** | Turn off the Wi-Fi access point. Announce it. Phones now show offline; their members note what they *would* have done and stop. |
| 0:15 to 2:15 | Outage | Laptop members trade offline: a certificate-backed payment to the merchant, a plain payment or two, a confirmation. They export to QR sheets. Couriers carry sheets to the steward, who ingests them and hands back receipt sheets. The slow courier holds one sheet back deliberately. One laptop "dies" (close the lid) after signing. If you have radios, push at least one bundle over LoRa. |
| 1:15 | **Emergency** (optional) | Declare a drill emergency from the console and co-sign it in person with the electorate present; pass one temporary measure through the compressed window. Watch the banner appear on phones when they reconnect. See [Emergencies](emergencies.md). |
| 2:15 | Power loss (encrypted profile only) | Pull the station's power. Convene the holders and run the unlock ceremony; read the fingerprint aloud. Time it. See [Encrypted at rest](../operators/encrypted-at-rest.md). |
| 2:45 | **Reconnect** | Wi-Fi back on. Phones sync and their members make the payments they were holding. Laptop members run `rrn wallet submit`. The slow courier finally delivers. |
| 3:00 | Reconcile | The steward reads every receipt outcome aloud: admitted, known, or refused and why. The adversary reveals what they tried. |
| 3:30 | Settle and debrief | Wait out the settlement window if you shortened it, or read the pending list. Debrief. |

## The adversary's brief

Choose two or three. The software should catch every one; the drill is to see
whether the people notice.

1. **Spend one certificate twice**, to two different receivers. Expect the
   second refused as an overspend when both arrive, and the member's standing
   gone. Use a throwaway identity, or accept the consequence.
2. **Hand a courier a sheet with one page missing.** Expect the rest to land
   and the author to re-send the missing record later.
3. **Scan the same sheet twice.** Expect the same receipt and nothing
   double-counted.
4. **Edit one character of a QR payload line** before ingest. Expect it
   refused with a bad-signature reason.
5. **Try to co-sign the emergency declaration** from an identity that is not
   in the electorate. Expect it refused.

## The log sheet

Record, per event: the time, who, what carrier, and the receipt outcome.
Afterwards verify with the steward:

- **Every value is conserved.** Balances across members still sum to zero.
  The software test checks exactly this; you check it on paper.
- **No record was silently lost.** Everything on the log sheet has a receipt
  or a known re-send.
- **Exactly the planted double-spend was flagged**, and nothing honest was.
- **No settlement happened before its window elapsed** from *arrival* at the
  station, not from when the record was signed.
- **The unlock ceremony completed** with the holders you actually had, in the
  time you actually took.

## What you are really testing

Not the software. You are testing whether everyone knows how to reserve a
certificate; whether the couriers can find the steward; whether the holders
answer the phone; whether the merchant trusts an offline payment from a
laptop they cannot check against the station; whether phone members
understand that "offline" means "wait", not "lost". Write down what surprised
you and fix the people-side before the storm.

## The debrief

Sit down together while it is fresh:

- Read the receipt outcomes and the emergency report aloud.
- For every refusal, ask whether the person understood why at the time.
- For every delay, ask who was waiting and what they did in the meantime.
- Decide one thing to change: a second courier, a printed "how to reserve"
  card, a UPS, a holder who lives closer.
- Put the settlement window and any other drill settings back, take a fresh
  backup, and schedule the next drill. Once a season is about right.

The software's own simulation, what it verifies, and what it deliberately
leaves to a drill like this one are described in
[the 72-hour outage simulation](https://github.com/railroad-network/station/blob/main/docs/phase-2-exit-evidence.md).
The steward's fuller checklist, with the exact console commands, is Part 6 of
[the operator runbook](https://github.com/railroad-network/station/blob/main/docs/community-setup.md).
