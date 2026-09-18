# What is a Common?

A **Common** is the unit everyone in a Railroad Network community trades in.
It is the same unit in every community, so that when communities eventually
connect, a Common earned in one place means something in another.

## It is mutual credit, not money

Nobody issues Commons. There is no treasury, no mint, and no way to create
them out of nothing. A Common comes into existence only when one member pays
another:

- Ana fixes Ben's bicycle. Ben pays Ana 5 Commons.
- Ben's balance goes from 0 to **−5**. Ana's goes from 0 to **+5**.
- Add up every balance in the community and you get **zero**. Always.

A positive balance means the community owes you. A negative balance means you
owe the community, in the form of goods or services someone will eventually
buy from you. Both are normal. A community where everyone is at zero is a
community where nobody is trading.

This is an old idea. Local Exchange Trading Systems have run this way in
hundreds of communities since the 1980s. The software adds a tamper-evident
history, a fraud-resistant way to confirm real-world trades, and the ability to
keep going with no internet.

## The debt floor

Because anyone can go negative, there has to be a limit. The **debt floor** is
the lowest balance you may sign yourself down to. The default is **−20
Commons**. A payment that would take you below it is refused by the software
before it ever reaches anyone.

The floor counts what has settled *and* what you have already signed but which
has not settled yet, so you cannot get around it by sending several payments
at once. It applies when you propose a payment and when you confirm a payment
request someone sent you.

A community can set its own floor in the station's configuration. The point is
not to punish debt; it is to bound how much any one person can take out
without giving back.

## Fractions

Amounts are shown in Commons, with up to two decimal places (2.50 Commons).
Under the hood the software only ever counts whole **centicommons**, one
hundredth of a Common, so there is no rounding and no floating-point error in
anything that gets signed.

## What a Common is worth

Whatever the community decides, by trading. There is no exchange rate to any
national currency and the software sets no prices. Communities tend to settle
on a rough anchor in conversation ("about an hour of ordinary work") and let
the marketplace do the rest.
