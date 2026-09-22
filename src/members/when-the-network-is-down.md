# When the network is down

Railroad Network was designed for the day the Wi-Fi, the internet, or the
power is gone. The rule is simple: **keep signing.** A member's device does not
need the station to sign a payment. It needs the station to *settle* one, and
that can happen later.

> **Where this stands today.** The design below is fully built on the station
> side and in the [command-line wallet](using-a-computer.md), and it is what the
> project's 72-hour outage simulation exercises. The **phone app does not do
> it yet**: when the app cannot reach the station it refuses to send, confirm,
> vote, or contest, tells you so, and you try again when connected. Nothing is
> queued on the phone. The Rust core behind the app already has the outbox,
> certificate, and bundle functions; the screens are not written. Until they
> are, a phone member's offline options are to wait, or to trade on paper
> through a member with a laptop. The rest of this page describes the
> mechanism as it exists, so you know what a receipt or a certificate is when
> you meet one.

## What actually happens

When a device cannot reach the station, anything it signs goes into an
**outbox**. It is still a real, signed record; it is just undelivered. When the
station is reachable again, by any route, the outbox drains, the station
checks each record, and sends back a **receipt** saying whether it was
admitted. Settlement windows start counting from arrival, not from when the
record was signed, so a delayed record can never shortcut the window in which
it can be contested.

Routes a record can take:

- **Wi-Fi, later.** Walk back into range and the wallet delivers it by itself
  (`rrn wallet submit` on a laptop).
- **Paper.** Export the outbox as QR codes, print or photograph them, and a
  courier carries the sheet to the station's [courier desk](../operators/courier-desk.md).
  Receipts come back the same way.
- **Radio.** Where the community has set up LoRa radios, a bundle hops over
  the air with no infrastructure. See [Radio and text message](../operators/radio-and-sms.md).
- **Text message.** Designed and tested, but the physical gateway is not
  built. Do not count on it today.

A courier needs no trust. Every record is signed by its author and re-checked
by the station. A courier can lose or delay what they carry. They cannot forge
or alter it. Sending the same record twice is always safe: the station
recognises it and never admits a payment twice.

> **A receipt is proof. The absence of one is not proof of anything.** Keep
> re-sending until the receipt comes back.

## Before the storm: headroom certificates

Here is the one problem offline cannot solve by itself. When you pay someone
offline, they cannot see your balance, so they cannot know whether the payment
will clear the debt floor when it finally arrives.

A **headroom certificate** fixes that. While you are still connected, you ask
the station to reserve part of your credit headroom, say 10 Commons. The
station signs a certificate saying so. Later, offline, you pay against it: the
receiver checks the certificate is genuine, is yours, has room, and has not
expired. They can hand over the goods knowing the credit was already set
aside. The command-line wallet requests, holds, and spends against
certificates and writes a **spend voucher** the receiver can verify without
the station; the operator can also print a certificate as a wallet card.

The trade is that reserved headroom is idle headroom. A 10-Common certificate
is 10 Commons you cannot spend online until it expires or you return it. So the
habit is: reserve before a market day, a storm warning, or a trip up the
valley; return what you did not use when you are back.

Defaults a community can change (see [Configuration](../reference/configuration.md)):

| Rule | Default |
| --- | --- |
| Most one certificate can reserve | 10 Commons |
| Live certificates one member may hold | 4 |
| How long a certificate can be spent against | 7 days |
| How late a spend against it may arrive and still count | 14 days |

## The one thing you must not do

A certificate holder could try to spend the same certificate twice with two
different people, each of whom can only see the spends the payer chooses to
show. The cap on the certificate bounds what the community can lose. When both
records reach the station, the second is refused and the double-spend is
recorded as **provable equivocation**: your standing drops to nothing, you can
issue no new certificates, and a jury case opens.

This is the one fraud the system cannot prevent offline, only price. The price
is your whole standing. The rules are locked in
[ADR-0021](https://github.com/railroad-network/station/blob/main/docs/adr/0021-escrowed-offline-spending-certificates.md)
and [ADR-0025](https://github.com/railroad-network/station/blob/main/docs/adr/0025-equivocation-dispute-cases.md).

## What the station does meanwhile

Nothing settles, no window runs, and no vote closes while the station is
unreachable; it is the one thing that writes the community's history, by
design ([ADR-0020](https://github.com/railroad-network/station/blob/main/docs/adr/0020-single-writer-log-dtn-submission.md)).
Members' outboxes preserve everything signed. When the station comes back,
whether from a power cut or from a restored backup, the outboxes replay and
the history continues. How a community rehearses all this is
[Running an outage drill](../organizers/outage-drill.md).
