# When the network is down

Railroad Network was designed for the day the Wi-Fi, the internet, or the
power is gone. The rule is simple: **keep signing.** Your phone does not need
the station to sign a payment. It needs the station to *settle* one, and that
can happen later.

## What actually happens

When your phone cannot reach the station, anything you sign goes into an
**outbox**. It is still a real, signed record; it is just undelivered. When
the station is reachable again, by any route, the outbox drains, the station
checks each record, and sends back a **receipt** saying whether it was
admitted. Settlement windows start counting from arrival, not from when you
signed.

Routes a record can take:

- **Wi-Fi, later.** Walk back into range and the app delivers it by itself.
- **Another member's phone.** A paired phone that comes into range submits
  whatever it is carrying.
- **Paper.** Export your outbox as QR codes, print or photograph them, and a
  courier carries the sheet to the station. Receipts come back the same way.
- **Radio.** Where the community has set up LoRa radios, records hop over the
  air with no infrastructure.
- **Text message.** Designed and tested, but the physical gateway is not built
  yet. Do not count on it today.

A courier needs no trust. Every record is signed by you and re-checked by the
station. A courier can lose or delay what they carry. They cannot forge or
alter it. Sending the same record twice is always safe.

> **A receipt is proof. The absence of one is not proof of anything.** Keep
> re-sending until the receipt comes back.

## Before the storm: headroom certificates

Here is the one problem offline cannot solve by itself. When you pay someone
offline, they cannot see your balance, so they cannot know whether the payment
will clear the debt floor when it finally arrives.

A **headroom certificate** fixes that. While you are still connected, you ask
the station to reserve part of your credit headroom, say 10 Commons. The
station signs a certificate saying so. Later, offline, you pay against it: the
receiver's phone checks the certificate is genuine, is yours, has room, and has
not expired. They can hand over the goods knowing the credit was already set
aside.

The trade is that reserved headroom is idle headroom. A 10-Common certificate
is 10 Commons you cannot spend online until it expires or you return it. So the
habit is: reserve before a market day, a storm warning, or a trip up the
valley; return what you did not use when you are back.

Defaults a community can change:

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
is your whole standing.
