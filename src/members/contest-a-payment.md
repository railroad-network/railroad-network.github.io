# Contest a payment

Something went wrong with a trade: the goods never came, the work was not
done, the amount is not what you agreed, or you never made the payment at
all. If the payment is still in its settlement window, you can **contest**
it. This page is the member's side; how the jury itself works is under
[Disputes](../organizers/disputes.md).

## When you can

Only while the payment is **confirmed but not yet settled**: inside the
24-hour window for a Tier 1 payment or the 48-hour window for Tier 2. After
settlement the payment is final, and the only remedy is a new payment the
other way, agreed between you.

Either party can contest: the payer or the receiver.

## How

In the app, open the payment from your transaction history and choose
**Contest**. From the command-line wallet it is `rrn wallet dispute`. You
write a short reason. If you have evidence held somewhere else, such as
photos or a message thread, you can attach its fingerprint so it can be
checked later.

Contesting **freezes that one payment**. Nothing else about your account
changes.

## If someone contests yours

You are notified in the app and may file a **response**. You do not have to.
The jury sees the reason, your response if any, and the payment itself. Keep
your response factual; it is signed by you and lives in the history.

## What happens next

The software draws **three jurors** by lot from the established members,
weighted by standing and never including either party. Each rules to uphold
the dispute or reject it. Majority wins:

- **Upheld.** The payment is voided and balances do not move. The member who
  *confirmed* it loses some standing, because confirming was their claim
  that the trade happened.
- **Rejected.** The payment settles as normal.
- **Nobody rules in time.** The dispute lapses and the payment settles. Every
  path fails toward the status quo, so a dispute can never freeze a payment
  forever.

If you disagree with the ruling you can **appeal** to the whole electorate of
established members, which suspends the ruling while they vote. If no jury
can be seated at all, a party can **escalate** straight to the electorate.
Both run on bounded windows and lapse the same way.

## If you are drawn as a juror

You may be drawn for a dispute you have nothing to do with. The app tells
you, shows you the payment, the reason, and any response, and asks for your
verdict before the window closes. Rule on what you can see. There is no
obligation to investigate, and no penalty for how you rule, but a panel that
does not reach a majority in time lets the dispute lapse, so do not sit on
it.

## Good habits

- **Look at pending payments each day** while the community is new. The
  window is short by design.
- **Contest, then talk.** Contesting costs nothing and preserves your
  position. Most disputes get resolved by the two people before the jury
  does anything, and a rejected or lapsed dispute has no consequence for the
  person who raised it.
- **Confirm carefully in the first place.** Confirming is the moment you put
  your standing behind the trade. Nearly every upheld dispute traces back to
  a confirmation that should not have happened.
