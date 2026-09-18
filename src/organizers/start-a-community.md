# Start a community

A community exists once its **Charter** is ratified: the founding document
that names the community, states its principles and guaranteed rights, and
lists its founders. Until then, phones can pair and look around, but
governance and disputes have nothing to stand on.

This page is the organizer's half. The operator's half, standing up the
station and pairing phones, is [Run a station](../operators/run-a-station.md).

## Choose your founders

Founders matter beyond ceremony. Standing is earned through vouches and trade,
which takes time. To avoid a dead zone where nobody can vote or sit on a jury,
a young community runs in **bootstrap grace**: while fewer than three members
are established, the electorate is the founders plus whoever is established.
Your founders *are* the functioning government of the early community.

Three to five trusted people is a good shape for a pilot of around twenty.
Fewer, and one absence stalls everything. More, and the ceremony drags.

## Write the Charter

The Charter has three kinds of content:

- **A community id.** A short, stable name like `maple-street-commons`.
- **Principles.** What the community is for. "Mutual aid before profit."
  "Decisions in the open."
- **Rights.** What no vote can take away from a member. "Any member may call
  a vote." "Any member may contest a transaction."

Keep it short. A Charter is hard to change on purpose: amendments chain to the
version they replace, need a higher bar than ordinary rules, and are frozen
entirely during an emergency. Put durable values here and leave details to
statutes.

## Run the signing ceremony

There are two ways to found. Use the second.

**Solo bootstrap.** One command at the station makes the station's own wallet
the sole founder. Quick, and fine for a technical trial. But it makes the
operator the whole grace-period electorate, which is not a founding story a
real community should tell.

**The founding ceremony.** Founders keep their keys on their own phones and
sign there. The operator opens the ceremony from the station, declaring the
community id, principles, rights, and each founder's `rrn1…` address. Each
founder then opens the app, Community → Governance, sees "Sign the founding
charter", reads it, and taps **Sign**. The Charter publishes by itself once
**three quarters of the declared founders** (rounded up) have signed.

Read the Charter aloud before anyone signs. It must say exactly what was
declared; a founder who finds a typo should refuse and the ceremony is
reopened.

The exact commands are in the operator's runbook under
[Found the community](https://github.com/railroad-network/station/blob/main/docs/community-setup.md#part-3--found-the-community).

## The first weeks

- **Vouch for everyone you actually know**, and encourage members to vouch for
  each other. Vouches plus trade are what lift people to established, which is
  what ends bootstrap grace.
- **Trade something real early.** A community with an empty ledger has no
  standing anywhere. Even play-stake trades build the history that governance
  depends on.
- **Set up social recovery**, both for members and for the station. The
  operator arms the station's recovery with a few trusted members as holders.
  Founders are natural candidates.
- **Read the phase warnings.** This is pilot software with no independent
  audit. Say so in your first meeting.
