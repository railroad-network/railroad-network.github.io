# Start here

Ten minutes of orientation. After this, the section for your role stands on
its own.

## The shape of a community

A Railroad Network community is small and concrete: **one station** and **the
phones that can reach it**.

- The **station** is an ordinary computer, often a Raspberry Pi, that one
  person keeps running. It holds the community's ledger: the single, signed,
  tamper-evident history of every payment, vouch, vote, and dispute. It is the
  only thing that writes that history.
- Each **member** holds their own key on their own phone (or on a laptop, with
  the command-line wallet). The station cannot spend, vote, or speak for a
  member. It can only record what members have signed.
- The **organizers** are the founders and whoever the community's charter says
  makes decisions. In the software they are just members with a role in
  governance, not administrators with special powers.

There is no company in the middle, no cloud, and today no connection between
communities. Federation between communities is planned, but it comes after
making a single community resilient, which is where the project is now.

## The five ideas

**The Common.** The unit of account. Balances start at zero and can go
negative; that is how mutual credit works. A floor stops anyone from signing
themselves too far into debt. [More](members/what-is-a-common.md).

**Vouching and standing.** New members are vouched for by existing ones.
Trade and vouches build a **standing** score that the software computes from
the history, using one formula that no community can tune. Enough standing
makes you an **established member**: someone who can vote and sit on a jury.
[More](members/vouching-and-standing.md).

**Settlement windows.** A payment does not move balances the moment it is
confirmed. It waits a day or two, during which either side can contest it.
Then it settles. [More](members/pay-and-get-paid.md).

**The Charter and the log.** The founders sign a charter. Every rule since is
a proposal, co-signed and voted on, recorded in the same history as payments.
Disputes go to a jury of three drawn by lot. [More](organizers/how-decisions-get-made.md).

**Offline is normal mode, running late.** Members keep signing when the
station is unreachable. Their records travel later over whatever works and
settle on arrival. [More](members/when-the-network-is-down.md).

## What to read next

- **Members:** [Install the app](members/install-the-app.md), then
  [Join your community](members/join-your-community.md).
- **Organizers:** [Start a community](organizers/start-a-community.md).
- **Operators:** [Run a station](operators/run-a-station.md).
- **Everyone:** the [Glossary](reference/glossary.md) when a word is new.
