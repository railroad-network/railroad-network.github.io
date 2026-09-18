# Vouching and standing

There is no sign-up form and no identity check. You become a real member of a
community the way you would in a village: someone who is already known says
they know you.

## Vouching

A **vouch** is a signed statement from one member that another member's key
belongs to a real, known person. It is recorded in the community's history
like everything else.

Vouching is not free. When you vouch for someone you put a little of your own
standing behind them. If they turn out to be a fraud, or a second key for a
person who already has one, it costs you. So vouch for people you actually
know, and expect the same of others.

To vouch: find the person in the community list, check the address on their
phone matches the one you see, and tap **Vouch**. Vouching needs the station
reachable; it is one of the few things you cannot queue up offline.

## Standing

**Standing** is the score the software computes for every member from the
history: vouches received, trades completed, disputes lost, and how recently.
Two things about it are unusual:

- **It is never stored, only computed.** Any station can replay the history
  and arrive at the same number. There is no field an administrator can edit.
- **The formula is the same everywhere.** No community can tune it. This is a
  deliberate choice so that standing means the same thing across communities
  when they eventually connect.

Your Standing screen shows your composite score and what feeds it. Standing
decays slowly if you stop taking part, so it reflects who you are now, not who
you were.

## Established members

Once your standing crosses a threshold (a composite score of 2.0) and your
identity is anchored by vouches, you are an **established member**. Established
members are the community's electorate: they vote on proposals, sit in the jury
pool for disputes, and can be recovery holders for the station.

A community with fewer than three established members is in **bootstrap
grace**: the founders stand in as the electorate so the community can govern
itself from day one. The app shows a banner while grace is on. It ends by
itself.

## Limits on new members

To make it expensive to flood a community with fake people, the software rate
limits how quickly a member can vouch and how fast a new identity can gain
standing. If a vouch is refused with a velocity message, wait and try later;
it is not personal.
