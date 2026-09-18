# Security and audits

> **Do not use this with real value.** Not yet.

## Where things stand

An internal, AI-assisted security review of both the station and the mobile
app was completed in August 2026. It found **no High-severity issues**, with a
handful of Medium and Low findings concentrated at the pairing and recovery
ceremony surfaces and at platform exposure on the phone (clipboard, screen
capture, keychain accessibility). The full reports, with each finding's
failure scenario and remediation order, are public:

- [Station audit, 2026-08](https://github.com/railroad-network/station/blob/main/docs/security/audit-2026-08.md)
- [Mobile audit, 2026-08](https://github.com/railroad-network/mobile/blob/main/docs/security/audit-2026-08.md)
- [Phase 2 red-team notes](https://github.com/railroad-network/station/blob/main/docs/security/phase-2-redteam.md)

That review was a **code review performed by an AI model** operated by the
maintainer. It is not a penetration test and not an attestation by a
professional security firm. It was meant to raise the floor, not to clear the
stack for production. An independent professional audit remains warranted
before any deployment where real people depend on this software, and it has
not happened yet.

## The threat model

The project keeps a living, STRIDE-organized threat model that grows with
each component and states plainly what is *not* mitigated:

- [Threat model](https://github.com/railroad-network/station/blob/main/docs/threat-model.md)

Some limitations worth knowing as a user:

- **A compromised phone or station OS is out of scope.** The software
  defends the wire and the disk; it cannot defend against a machine that is
  already someone else's.
- **Radio and SMS leak metadata.** They carry only signed, public records, but
  a radio has a location and a phone number has an owner. Communities under
  surveillance pressure should prefer paper for sensitive traffic.
- **Offline double-spending cannot be prevented, only priced.** See
  [When the network is down](../members/when-the-network-is-down.md).

## Reporting a vulnerability

Please do not open a public issue for a security problem. See the
[security policy](https://github.com/railroad-network/station/blob/main/SECURITY.md)
in the `station` repo for how to reach the maintainers privately.
