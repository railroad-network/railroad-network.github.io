# The marketplace

The marketplace is where the economy becomes daily life: what people have,
what people need, and the conversation that turns one into the other. It is
built into the app and the command line, and like everything else it is a
set of signed records in the community's history.

## Three surfaces

| Surface | What goes there | Example |
| --- | --- | --- |
| **Goods** | Physical things, counted | Eggs by the dozen, a spare bike wheel |
| **Services** | Time and skill, one-off or recurring | An afternoon of fencing, weekly childcare |
| **Commons** | Community-pooled resources at low or no cost | The tool library, the shared hall |

A Commons listing may carry a **negative price**: a subsidy, where the
community pays members to take part. Nothing else can.

Every listing has a **category** from a fixed list (agriculture,
construction, education, food, medical, tools, transportation, other) so that
needs can be matched to offers without guessing at words.

## Offering something

A **listing** is a signed offer: a surface, a category, a title, a
description, a price in Commons, availability, and optionally an expiry and
requirements. Requirements let you say that only members above a certain
standing, or only members of this community, may take it up.

After publishing you can change the price, description, availability, and
expiry. You cannot change the surface, category, title, or requirements;
those are what the listing *is*. Close a listing when it no longer applies.

A listing's track record is not something you write. The count of completed
trades against it is computed from settled payments that reference it, so
nobody can claim a history they do not have.

## Looking for something

You can **browse** the listings by surface, category, free text, price cap,
and the provider's minimum standing. Or you can post a **need**: a category,
a quantity, the most you will pay, and how long the need stands. The station
then shows you the **matches**, the listings that answer it, and keeps
matching as new listings appear.

## Agreeing a price

An **inquiry** is the conversation between a buyer and a listing's provider.
The buyer opens it, accepting the listed price or making an offer, with a
message. Either side replies, with a counter-offer or without. The provider
closes it as **agreed**, at a price, or **declined**.

The inquiry is the place to sort out details: when, where, how many. Nothing
moves until it is agreed.

## Paying for what you agreed

Once an inquiry is agreed, the buyer **settles** it. That signs a payment at
the agreed price, linked to the listing, which the provider then confirms
like any other payment. It settles after the usual window and appears in
both members' history naming the listing it paid for. See
[Pay and get paid](pay-and-get-paid.md).

Only the buyer can settle an inquiry, and settling it twice returns the same
payment rather than paying twice.

## Recurring services

For a service that repeats, such as weekly deliveries or a standing patrol,
the buyer signs a **contract** from an agreed inquiry instead of a one-off
payment. The contract records the terms; charges against it are payments
linked to the contract as they fall due. Either party can end a contract
early.

## Rules of the road

- **Describe honestly.** A listing is signed by you and lives in the history
  forever. So does a dispute over it.
- **Link the payment.** Settling from the inquiry, rather than paying the
  provider directly, records what the payment was for. That is what a jury
  sees if it is ever contested.
- **Standing requirements cut both ways.** You can require a minimum standing
  of buyers; providers with little standing will find fewer takers.
- **Not visible across communities yet.** Listings are local until federation
  arrives.

## From the command line

Members using the [command-line wallet](install-the-app.md#using-a-computer-instead)
and operators at the station console have the same marketplace under `rrn`:
`list`, `browse`, `need`, `matches`, `inquire`, `inquiry-reply`,
`inquiry-close`, `settle-inquiry`, and `contract`. The
[command reference](../reference/cli/rrn.md#rrn-list) has every option.

The data model is locked in
[ADR-0010](https://github.com/railroad-network/station/blob/main/docs/adr/0010-marketplace-data-model.md).
