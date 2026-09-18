# About the reference

The reference section is the exact, terse layer under the rest of this site:
what every command does, what every word means, and where the design
decisions are written down.

- [Glossary](glossary.md): the project's vocabulary, one paragraph each.
- [rrn command reference](cli/rrn.md) and
  [station command reference](cli/station.md): the built-in help for every
  command, generated from the code.
- Configuration *(page not yet written)*: every key in `config.toml` with its default.
- [Architecture decision records](adrs.md): the locked-decision record, with
  links.
- [Wire specifications](specs.md): QR payloads, bundles, SMS, the boot
  ceremony.

## What is authoritative

This site explains. The `station` repo decides. In order of authority:

1. **The ADRs** in `station/docs/adr/`. Append-only; a changed decision gets a
   new ADR that supersedes the old one.
2. **The wire specs** in `station/docs/spec/`.
3. **The design overview** in `station/docs/design/`, which predates parts of
   the implementation and says so where it conflicts with an ADR.
4. **This site.**

If a page here disagrees with an ADR, the page has a bug.
[Tell us](../project/contributing.md).
