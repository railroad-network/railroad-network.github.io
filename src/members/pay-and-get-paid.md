# Pay and get paid

A payment in Railroad Network is a conversation between two people, witnessed
by the station, with a pause built in before it becomes final.

## The three steps

1. **Propose.** You sign a payment to someone's address for an amount. The
   software checks it would not take you below the [debt floor](what-is-a-common.md#the-debt-floor)
   and sends it to the station.
2. **Confirm.** The receiver sees the proposal and confirms it. Nothing moves
   yet. Confirming starts the **settlement window**.
3. **Settle.** When the window closes with no dispute, the station records the
   settlement and both balances move. The payment is now final.

A proposal that is never confirmed simply expires. Either party can also
cancel before settlement.

You can also **request** a payment: you sign a request, the payer confirms it.
The debt-floor check then runs against the payer at confirmation time.

## The settlement window

| Payment size | Tier | Window |
| --- | --- | --- |
| Small | Tier 1 | 24 hours |
| Larger | Tier 2 | 48 hours |
| 50 Commons and up | Tier 3 | Not available yet: the payment is refused, not shrunk |

The window is the community's chance to catch a mistake or a lie. During it,
either party can [contest the payment](../organizers/disputes.md), which
freezes settlement until a jury rules. If nobody contests, it settles.

Larger (Tier 2) payments ask more of the person confirming: they need enough
standing to stake on it, and an upheld dispute costs them some of that
standing. This is what makes confirming a real-world trade you did not
actually receive a bad idea.

Payments at or above 50 Commons would need evidence the software cannot yet
weigh, so for now they are refused outright. Split a large trade into smaller
payments over time, or wait for a later phase.

## What "pending" means

Your balance screen shows two numbers: what has **settled**, and what is
**pending** (confirmed but still in its window, or signed but not yet
delivered to the station). Pending amounts already count against your debt
floor, so you cannot spend the same headroom twice.

If you signed a payment while out of range of the station, it stays pending
until it gets there, whether over Wi-Fi later, via another member's phone, or
on paper. See [When the network is down](when-the-network-is-down.md).

## Good habits

- **Confirm only what you actually received.** Confirming is the moment you
  put your standing behind the claim that the trade happened.
- **Contest inside the window.** After settlement the payment is final; the
  only remedy is a new payment the other way.
- **Link marketplace payments to the listing.** Paying for an agreed inquiry
  from the marketplace records what the payment was for, which helps if it is
  ever disputed.
