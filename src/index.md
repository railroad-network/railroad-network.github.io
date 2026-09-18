# Welcome

Railroad Network is a way for a community to run its own economy, identity, and
decision-making on hardware it owns, and to keep doing so when the internet,
the grid, or the institutions around it stop working.

Members trade in a shared credit called the **Common**. Nobody issues it and
nobody can print more of it: when you pay a neighbour, your balance goes down
and theirs goes up, and the community as a whole always sums to zero. Who you
are is a key on your own phone, backed by people who **vouch** for you, not by
an account on someone's server. Rules are written in a **Charter** the founders
sign, changed by votes, and enforced by juries drawn by lot. When the network
is gone, payments travel by radio, by text message, or on a printed sheet in
someone's pocket, and settle when they arrive.

The name is a nod to the Underground Railroad: a network of trusted people,
under hostile conditions, with no central authority, whose real strength was
its human trust architecture. This software tries to encode those principles.

> **Do not use this with real value.** Railroad Network is research-stage
> software. The cryptography has had an internal review but no independent
> professional audit. Run a pilot with play stakes, not livelihoods. See
> [Security and audits](project/security.md) for exactly where things stand.

## Who these pages are for

This site is written for people, not for the code. Pick the door that fits:

| You are... | Go to |
| --- | --- |
| Someone who wants to use the app, pay people, and take part | [For members](members/index.md) |
| Someone founding or stewarding a community: charter, votes, disputes | [For organizers](organizers/index.md) |
| Someone running the station computer that the community's phones talk to | [For operators](operators/index.md) |
| Someone who wants the exact commands, the glossary, or the design record | [Reference](reference/index.md) |

Not sure? Read [Start here](start-here.md).

## Where the software lives

The code is public and dual-licensed (Apache-2.0 or MIT):

- [`station`](https://github.com/railroad-network/station): the Rust daemon
  and command-line client, and the engineering record (design overview,
  decision records, threat model, audits).
- [`mobile`](https://github.com/railroad-network/mobile): the Android app.

When this site and a decision record in `station` disagree, the decision
record is right and this site has a bug. [Tell us](project/contributing.md).
