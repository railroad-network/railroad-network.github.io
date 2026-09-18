# Railroad Network — documentation site

The human-facing documentation for [Railroad Network](https://github.com/railroad-network),
published at <https://railroad-network.github.io>.

The engineering record — Architecture Decision Records, wire specs, the threat
model, and the security audits — stays in the
[`station`](https://github.com/railroad-network/station) repo and is the
authority when the two disagree. This site explains that record in plain
language for three audiences: **members** who use the app, **organizers** who
run a community, and **operators** who run a station.

## Working on the site

It is an [mdBook](https://rust-lang.github.io/mdBook/) book: Markdown in
`src/`, one sidebar in `src/SUMMARY.md`.

```sh
cargo install mdbook --locked   # once
mdbook serve --open             # live preview at http://localhost:3000
mdbook build                    # static output in book/
```

The `rrn` and `station` command references and the ADR index are generated
from the `station` checkout next to this one, not written by hand:

```sh
scripts/gen-reference.sh            # expects ../station; override with STATION=/path
```

Re-run it after a CLI change lands in `station`, then commit the result.

Every push to `main` deploys to GitHub Pages via
`.github/workflows/pages.yml`. Pull requests only build. The built `book/`
directory is a self-contained static site: it works from a USB stick or a
station's local web server with no internet, which matters for this project.

Conventions for writing pages are in
[`src/project/about-these-docs.md`](src/project/about-these-docs.md).

## License

Licensed under either of [Apache License, Version 2.0](LICENSE-APACHE) or
[MIT license](LICENSE-MIT) at your option, matching the rest of the project.
