# Wire specifications

The byte-level formats, for anyone building a client, a scanner app, or a
carrier. They live in the `station` repo and are the authority.

| Spec | What it defines |
| --- | --- |
| [QR payloads](https://github.com/railroad-network/station/blob/main/docs/spec/qr-payloads.md) | The `rrnp:`, `rrncert:`, and `rrnspend:` text formats printed as QR codes for the paper path, including chunking. |
| [DTN bundles](https://github.com/railroad-network/station/blob/main/docs/spec/dtn-bundles.md) | The delay-tolerant bundle a courier, radio, or phone carries to the station, and the receipt that comes back. |
| [SMS carrier](https://github.com/railroad-network/station/blob/main/docs/spec/sms-carrier.md) | Records as text-message chunks, the sender registry, rate caps, and what is reserved for the not-yet-built modem gateway. |
| [VMK boot ceremony](https://github.com/railroad-network/station/blob/main/docs/spec/vmk-boot-ceremony.md) | The request and response formats of the encrypted-at-rest unlock ceremony. |

Two rules every format follows:

- **Anything signed is canonical CBOR.** The signature covers the
  deterministic encoding of the payload, never the envelope it travels in, so
  the same record is byte-identical on every platform.
- **Carriers are dumb.** Radio, SMS, paper, and the phone transport see only
  signed, already-public records. None of them is an identity, integrity, or
  encryption boundary.

The mobile app verifies its encodings against fixtures in the `station` repo,
so a new signed record kind always lands in both.
