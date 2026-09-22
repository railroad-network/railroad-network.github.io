# About these docs

This site is an [mdBook](https://rust-lang.github.io/mdBook/) book in the
[`railroad-network.github.io`](https://github.com/railroad-network/railroad-network.github.io)
repo. Markdown in `src/`, one sidebar in `src/SUMMARY.md`, deployed to GitHub
Pages on every push to `main`.

## Building locally

```sh
cargo install mdbook --locked   # once
mdbook serve --open             # live preview
```

The `book/` directory that `mdbook build` produces is a self-contained static
site. It works from a USB stick, or served by a station on the local network,
with no internet. Communities are encouraged to keep a copy.

## Generated pages

The command references and the ADR index are generated from a `station`
checkout, not written by hand. After a CLI change lands there:

```sh
scripts/gen-reference.sh    # expects ../station; STATION=/path overrides
```

Commit the result.

## How the site is organized

Four sections by **audience**, not by component:

- **For members**: tutorials and how-tos for people using the app.
- **For organizers**: how founding, governance, disputes, and emergencies
  work, in plain language.
- **For operators**: runbooks for the station computer.
- **Reference**: exact commands, the glossary, and pointers to the decision
  records.

Every page in the sidebar is written. If a future page is planned before it
is written, add it to `SUMMARY.md` as a draft entry, `[Title]()`, and the
sidebar shows it greyed out with no link; replace the empty parentheses with
the real path when the file exists.

Two pages are hand-maintained mirrors of the code rather than generated:
[Configuration](../reference/configuration.md) follows the station's config
source, and the operator pages follow the runbooks in the `station` repo.
When a runbook changes, the page that draws on it changes in the same pull
request or the next.

## Writing conventions

- **Plain language.** Say "the community's history", then introduce "the
  log". Every term of art appears in the [Glossary](../reference/glossary.md).
- **Explain, then link to the record.** A governance or ledger rule gets a
  human explanation here and a link to the ADR that locks it. Never restate
  numbers the ADR owns without linking it.
- **The ADR wins.** If you find a conflict, fix the page.
- **Callouts are blockquotes** starting with a bold lead: `> **Warning.**`,
  `> **Tip.**`, `> **Generated page.**`
- **Amounts in Commons** in prose, with the centicommon rule mentioned once
  where it matters.
- **No ticket numbers, no milestone codes.** Cite the ADR or describe the
  behavior. Tickets are ephemeral; the docs must stand on their own.
- **The warning stays.** "Do not use with real value" appears on the welcome
  page and each section's overview until an independent audit says otherwise.
- **Say what ships, not what is designed.** Where the phone app lags the
  station (today: offline signing, certificates, paper export), the page says
  so in a callout and points to the command-line wallet. The
  [status page](status.md) is the one list of gaps; keep it current.
