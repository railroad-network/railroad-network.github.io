# `rrn` command reference

`rrn` is the command-line client. It is three things in one binary: the operator's console for a running station, the verify-only paper courier tools, and the self-custody member wallet for people who use a computer instead of a phone.

> **Generated page.** This is the `--help` text of every command, captured from a
> build of the [`station`](https://github.com/railroad-network/station) repo
> by `scripts/gen-reference.sh`. Edit the help strings there, not this file.

## `rrn`

```text
The Railroad Network rrn CLI: the operator console (a thin client over the station's Unix socket), the verify-only paper courier tools, and the self-custody member wallet (ADR-0028).

Usage: rrn [OPTIONS] <COMMAND>

Commands:
  init                Explain how to bootstrap a station (init runs in the daemon, not here)
  whoami              Print this station's own address
  status              Show the station's connectivity / offline posture: per-peer reachability, the mobile listener state, and pending DTN queue depths
  balance             Show a balance (defaults to your own)
  pay                 Propose a payment to another identity
  confirm             Confirm a proposed payment addressed to you
  history             Print recent log history
  transactions        Show settled and pending transactions, naming the listing each marketplace payment settled
  vouch               Vouch for another identity
  backup              Export a social-recovery package sealed to a set of holders
  recover             Reconstruct an identity from a recovery package and decrypted shards
  list                Publish a listing offering something to the marketplace
  browse              Browse what is on offer
  show-listing        Show one listing in full
  my-listings         Show the listings you have published, in any state
  edit-listing        Edit one of your own listings. Only price, description, availability, and expiry can change; surface, category, title, and requirements are fixed at publication. Each field left off is kept as it was
  close-listing       Take one of your own listings off offer
  need                Announce something you are looking for
  matches             Show the listings answering your needs
  inquire             Open an inquiry against a listing
  show-inquiry        Show one inquiry thread in full
  inquiries           Show the inquiries you are a party to
  inquiry-reply       Reply in an inquiry, optionally with a counter-offer
  inquiry-close       Close an inquiry: agree on a price, or decline
  settle-inquiry      Pay for an inquiry the provider has agreed. Signs a listing-linked payment at the agreed price, which the provider then confirms with `rrn confirm`. Only the inquiry's buyer may settle it; a second run returns the existing payment rather than paying twice
  contract            Sign up to a recurring service, from an inquiry the provider has agreed
  contracts           Show the service contracts you are a party to
  show-contract       Show one service contract in full
  terminate-contract  End one of your service contracts early
  governance          Community governance: the Charter, proposals, voting, and statutes (M1.9)
  dispute             Disputes: contest a confirmed payment, respond, rule as a juror, resolve (M1.10)
  cert                Offline spending certificates: reserve debt-floor headroom before a partition, and list your outstanding certificates (M2.3, ADR-0021)
  paper               Paper fallback: export payloads to printable QR sheets and ingest scanned QR text (M2.5, ADR-0020 §3 / ADR-0021 §4). The CLI consumes scanned QR *text* — one payload string per line, from any scanner app — it does not read camera images. A member exporting their *own* signed records prints them with `rrn wallet export` (ADR-0028); these tools are the courier's
  dtn                 Delay-tolerant networking: originate an outbound bundle push to a peer over the Reticulum transport, inspect tracked pushes, and publish this station's own reachability binding (M2.6, ADR-0013/0020)
  wallet              The self-custody member wallet (ADR-0028): hold your own key on a computer with no phone, sign payments offline into a durable outbox, carry them on paper or a DTN bundle, and pair/sync over the sealed channel when online
  help                Print this message or the help of the given subcommand(s)

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

### `rrn init`

```text
Explain how to bootstrap a station (init runs in the daemon, not here)

Usage: rrn init [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn whoami`

```text
Print this station's own address

Usage: rrn whoami [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn status`

```text
Show the station's connectivity / offline posture: per-peer reachability, the mobile listener state, and pending DTN queue depths

Usage: rrn status [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn balance`

```text
Show a balance (defaults to your own)

Usage: rrn balance [OPTIONS] [ADDRESS]

Arguments:
  [ADDRESS]
          The `rrn1…` address to query; omitted means your own

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn pay`

```text
Propose a payment to another identity

Usage: rrn pay [OPTIONS] <RECEIVER> <AMOUNT>

Arguments:
  <RECEIVER>
          The receiver's `rrn1…` address

  <AMOUNT>
          Amount in Commons, e.g. `3`, `3.5`, or `3.50`

Options:
      --memo <MEMO>
          Optional memo recorded in the signed proposal

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn confirm`

```text
Confirm a proposed payment addressed to you

Usage: rrn confirm [OPTIONS] <TX_ID>

Arguments:
  <TX_ID>
          The hex transaction id

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn history`

```text
Print recent log history

Usage: rrn history [OPTIONS]

Options:
      --limit <LIMIT>
          Maximum number of (most-recent-first) entries

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn transactions`

```text
Show settled and pending transactions, naming the listing each marketplace payment settled

Usage: rrn transactions [OPTIONS] [ADDRESS]

Arguments:
  [ADDRESS]
          The `rrn1…` address to view; omitted means your own

Options:
      --limit <LIMIT>
          Maximum number of (most-recent-first) rows

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn vouch`

```text
Vouch for another identity

Usage: rrn vouch [OPTIONS] <SUBJECT>

Arguments:
  <SUBJECT>
          The `rrn1…` address being vouched for

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --statement <STATEMENT>
          A free-text statement

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --stake <STAKE>
          Reputation to stake, in points, e.g. `1.50`

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn backup`

```text
Export a social-recovery package sealed to a set of holders

Usage: rrn backup [OPTIONS] --threshold <THRESHOLD> --output <OUTPUT> <HOLDERS>...

Arguments:
  <HOLDERS>...
          Holder `rrn1…` addresses (two or more)

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --threshold <THRESHOLD>
          `K` — how many shards are required to reconstruct

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --output <OUTPUT>
          Where to write the recovery package

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn recover`

```text
Reconstruct an identity from a recovery package and decrypted shards

Usage: rrn recover [OPTIONS] --package <PACKAGE>

Options:
      --package <PACKAGE>
          Path to a `.rrnrecovery` package

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --shards <SHARDS>
          Comma-separated decrypted raw-shard files

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn list`

```text
Publish a listing offering something to the marketplace

Usage: rrn list [OPTIONS] --price <PRICE> --category <CATEGORY> <SURFACE> <TITLE>

Arguments:
  <SURFACE>
          The surface to publish on
          
          [possible values: goods, services, commons]

  <TITLE>
          Short name for the offer

Options:
      --price <PRICE>
          Price in Commons, e.g. `3`, `3.5`, or `3.50`. Only a `commons` listing may be negative (a subsidy), written as `-3.50`

      --socket <SOCKET>
          Path to the station's Unix socket

      --category <CATEGORY>
          Category from the controlled vocabulary
          
          [possible values: agriculture, construction, education, food, medical, other, tools, transportation]

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

      --negotiable
          Invite offers on the price

      --description <DESCRIPTION>
          Longer prose describing the offer

      --capacity <CAPACITY>
          Units available (`goods` only)

      --next-slot <NEXT_SLOT>
          Next open slot, as a date or unix seconds (`services` only)

      --min-reputation <MIN_REPUTATION>
          Minimum reputation an inquirer must hold, in points e.g. `1.50`

      --community-only
          Deal only with members of your own community

      --oracle-tier <ORACLE_TIER>
          Oracle tier to claim; defaults to the price-based suggestion

      --expires <EXPIRES>
          Take the listing off offer after this date (or unix seconds)

      --every <EVERY>
          Make this a recurring service: how often a period falls due (`services` only)
          
          [possible values: daily, weekly, monthly]

      --periods <PERIODS>
          How many periods a recurring commitment runs for (required with `--every`)

      --notice <NOTICE>
          Days of notice to end a recurring contract early

      --penalty <PENALTY>
          Early-termination penalty in Commons, charged to whoever ends a recurring contract before its natural end

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn browse`

```text
Browse what is on offer

Usage: rrn browse [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --text <TEXT>
          Free-text query over titles and descriptions

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --surface <SURFACE>
          Only this surface
          
          [possible values: goods, services, commons]

      --category <CATEGORY>
          Only this category
          
          [possible values: agriculture, construction, education, food, medical, other, tools, transportation]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

      --max-price <MAX_PRICE>
          Only listings at or below this price, in Commons. May be negative, to look only at Commons-surface subsidies

      --min-reputation <MIN_REPUTATION>
          Only providers at or above this reputation, in points

      --limit <LIMIT>
          Page size

      --offset <OFFSET>
          Ranked hits to skip

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn show-listing`

```text
Show one listing in full

Usage: rrn show-listing [OPTIONS] <LISTING_ID>

Arguments:
  <LISTING_ID>
          The hex listing id

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn my-listings`

```text
Show the listings you have published, in any state

Usage: rrn my-listings [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn edit-listing`

```text
Edit one of your own listings. Only price, description, availability, and expiry can change; surface, category, title, and requirements are fixed at publication. Each field left off is kept as it was

Usage: rrn edit-listing [OPTIONS] <LISTING_ID>

Arguments:
  <LISTING_ID>
          The hex listing id

Options:
      --price <PRICE>
          New price in Commons, e.g. `3`, `3.5`, or `-3.50` (Commons subsidy)

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --negotiable <NEGOTIABLE>
          Invite offers (`--negotiable true`) or fix the price (`--negotiable false`). Omitted leaves the pricing model
          
          [possible values: true, false]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

      --description <DESCRIPTION>
          New description

      --capacity <CAPACITY>
          New units available (`goods` only)

      --next-slot <NEXT_SLOT>
          New next open slot, as a date or unix seconds (`services` only)

      --expires <EXPIRES>
          New expiry, as a date or unix seconds

      --clear-expiry
          Remove the expiry so the listing stands until closed. Wins over `--expires` if both are given

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn close-listing`

```text
Take one of your own listings off offer

Usage: rrn close-listing [OPTIONS] <LISTING_ID>

Arguments:
  <LISTING_ID>
          The hex listing id

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn need`

```text
Announce something you are looking for

Usage: rrn need [OPTIONS] --valid-until <VALID_UNTIL> <CATEGORY> <QUANTITY>

Arguments:
  <CATEGORY>
          Category from the controlled vocabulary
          
          [possible values: agriculture, construction, education, food, medical, other, tools, transportation]

  <QUANTITY>
          How many units you want

Options:
      --max-price <MAX_PRICE>
          The most you will pay, in Commons. May be negative, to seek only Commons-surface work that pays

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --valid-until <VALID_UNTIL>
          Valid through this date (`YYYY-MM-DD`), a `+<N>d` offset, or unix seconds

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn matches`

```text
Show the listings answering your needs

Usage: rrn matches [OPTIONS] [SEQ]

Arguments:
  [SEQ]
          The log seq of one need (from `rrn need`); omitted means all of them

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn inquire`

```text
Open an inquiry against a listing

Usage: rrn inquire [OPTIONS] <LISTING_ID>

Arguments:
  <LISTING_ID>
          The hex listing id

Options:
      --offer <OFFER>
          Your opening offer, in Commons; omitted accepts the listed price

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --message <MESSAGE>
          An opening message

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn show-inquiry`

```text
Show one inquiry thread in full

Usage: rrn show-inquiry [OPTIONS] <INQUIRY_ID>

Arguments:
  <INQUIRY_ID>
          The hex inquiry id

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn inquiries`

```text
Show the inquiries you are a party to

Usage: rrn inquiries [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn inquiry-reply`

```text
Reply in an inquiry, optionally with a counter-offer

Usage: rrn inquiry-reply [OPTIONS] <INQUIRY_ID>

Arguments:
  <INQUIRY_ID>
          The hex inquiry id

Options:
      --offer <OFFER>
          A counter-offer, in Commons

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --message <MESSAGE>
          The message body

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn inquiry-close`

```text
Close an inquiry: agree on a price, or decline

Usage: rrn inquiry-close [OPTIONS] --outcome <OUTCOME> <INQUIRY_ID>

Arguments:
  <INQUIRY_ID>
          The hex inquiry id

Options:
      --outcome <OUTCOME>
          How it ends
          
          [possible values: agreed, declined]

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --price <PRICE>
          The agreed price, in Commons (for `--outcome agreed`); omitted takes the listed price

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn settle-inquiry`

```text
Pay for an inquiry the provider has agreed. Signs a listing-linked payment at the agreed price, which the provider then confirms with `rrn confirm`. Only the inquiry's buyer may settle it; a second run returns the existing payment rather than paying twice

Usage: rrn settle-inquiry [OPTIONS] <INQUIRY_ID>

Arguments:
  <INQUIRY_ID>
          The hex id of the agreed inquiry

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn contract`

```text
Sign up to a recurring service, from an inquiry the provider has agreed

Usage: rrn contract [OPTIONS] <INQUIRY_ID>

Arguments:
  <INQUIRY_ID>
          The hex id of the agreed inquiry

Options:
      --metric <METRICS>
          A free-form note to record on the contract, as `key=value`; repeatable. No logic reads these; they are not part of the terms

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn contracts`

```text
Show the service contracts you are a party to

Usage: rrn contracts [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn show-contract`

```text
Show one service contract in full

Usage: rrn show-contract [OPTIONS] <CONTRACT_ID>

Arguments:
  <CONTRACT_ID>
          The hex contract id

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn terminate-contract`

```text
End one of your service contracts early

Usage: rrn terminate-contract [OPTIONS] <CONTRACT_ID>

Arguments:
  <CONTRACT_ID>
          The hex contract id

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn governance`

```text
Community governance: the Charter, proposals, voting, and statutes (M1.9)

Usage: rrn governance [OPTIONS] <COMMAND>

Commands:
  charter-init           Publish the community's genesis Charter. With no `--founder-key`, the station wallet is the sole founder (the one-command solo bootstrap); pass a founder key file per founder for a multi-founder genesis
  charter-begin          Open a distributed founding ceremony: declare the founders **by address** so a founder who holds their key on a phone can sign later, on-device, without ever handing over the secret. The Charter publishes automatically once `ceil(founders × 0.75)` have signed
  charter-status         Show the founding ceremony's progress: who has signed, the threshold, and the Charter body (`body_hex`) a station founder signs with `charter-sign`
  charter-sign           Sign a shared Charter body with this station's wallet, printing the `(pubkey, signature)` a station founder hands back to the coordinator
  charter-add-signature  Add a founder's collected signature to the pending Charter (a station founder's `charter-sign` output), publishing it if the threshold is met
  charter                Show the community's current (effective) Charter
  list                   List proposals with their phase and vote so far
  show                   Show one proposal in full
  propose                Author a proposal (signed by the station wallet)
  cosign                 Endorse a proposal, carrying it toward the co-sign threshold
  vote                   Cast a ballot on a published proposal
  statutes               List the statutes in force
  emergency-declare      Declare an emergency (ADR-0023): compresses the emergency-proposal window once a supermajority of the electorate co-signs. Signed by the station wallet, whose signature counts toward the threshold
  emergency-cosign       Co-sign an emergency declaration (or a lapse), toward its supermajority
  emergency-lapse        Raise a lapse to end an active emergency early; it takes effect once its own co-signatures reach the supermajority. Prints the lapse hash to co-sign
  emergency-status       Show the active emergency (if any) and the full derived timeline
  emergency-report       The post-emergency report: every activation, its co-signers, and the measures passed under it (ADR-0023 §6)
  help                   Print this message or the help of the given subcommand(s)

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance charter-init`

```text
Publish the community's genesis Charter. With no `--founder-key`, the station wallet is the sole founder (the one-command solo bootstrap); pass a founder key file per founder for a multi-founder genesis

Usage: rrn governance charter-init [OPTIONS] --community-id <COMMUNITY_ID>

Options:
      --community-id <COMMUNITY_ID>
          A stable identifier for the community

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --principle <PRINCIPLES>
          A founding principle; repeatable

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

      --right <RIGHTS>
          A guaranteed right; repeatable

      --founder-key <FOUNDER_KEYS>
          A file holding a founder's hex-encoded 32-byte secret key; repeatable. Omit entirely to sign with the station wallet as the sole founder

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance charter-begin`

```text
Open a distributed founding ceremony: declare the founders **by address** so a founder who holds their key on a phone can sign later, on-device, without ever handing over the secret. The Charter publishes automatically once `ceil(founders × 0.75)` have signed

Usage: rrn governance charter-begin [OPTIONS] --community-id <COMMUNITY_ID>

Options:
      --community-id <COMMUNITY_ID>
          A stable identifier for the community

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --principle <PRINCIPLES>
          A founding principle; repeatable

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

      --right <RIGHTS>
          A guaranteed right; repeatable

      --founder <FOUNDERS>
          A founder's bech32 `rrn1…` address; repeatable. Include the station's own address to have it co-sign at once

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance charter-status`

```text
Show the founding ceremony's progress: who has signed, the threshold, and the Charter body (`body_hex`) a station founder signs with `charter-sign`

Usage: rrn governance charter-status [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance charter-sign`

```text
Sign a shared Charter body with this station's wallet, printing the `(pubkey, signature)` a station founder hands back to the coordinator

Usage: rrn governance charter-sign [OPTIONS] --body <BODY_HEX>

Options:
      --body <BODY_HEX>
          The Charter body's canonical bytes, hex (the coordinator's `body_hex`)

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance charter-add-signature`

```text
Add a founder's collected signature to the pending Charter (a station founder's `charter-sign` output), publishing it if the threshold is met

Usage: rrn governance charter-add-signature [OPTIONS] --pubkey <PUBKEY_HEX> --signature <SIGNATURE_HEX>

Options:
      --pubkey <PUBKEY_HEX>
          The founder's public key, hex-encoded

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --signature <SIGNATURE_HEX>
          Their signature over the Charter body, hex-encoded

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance charter`

```text
Show the community's current (effective) Charter

Usage: rrn governance charter [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance list`

```text
List proposals with their phase and vote so far

Usage: rrn governance list [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance show`

```text
Show one proposal in full

Usage: rrn governance show [OPTIONS] <PROPOSAL_ID>

Arguments:
  <PROPOSAL_ID>
          The hex proposal id

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance propose`

```text
Author a proposal (signed by the station wallet)

Usage: rrn governance propose [OPTIONS] <TITLE> <BODY>

Arguments:
  <TITLE>
          The short title

  <BODY>
          The full body, markdown allowed

Options:
      --kind <KIND>
          Kind: `statute` (default), `administrative_rule`, or `emergency`
          
          [default: statute]

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --scope <SCOPE>
          The scope, required for `administrative_rule`

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

      --expires-at <EXPIRES_AT>
          Unix seconds an `emergency` measure expires

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance cosign`

```text
Endorse a proposal, carrying it toward the co-sign threshold

Usage: rrn governance cosign [OPTIONS] <PROPOSAL_ID>

Arguments:
  <PROPOSAL_ID>
          The hex proposal id

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance vote`

```text
Cast a ballot on a published proposal

Usage: rrn governance vote [OPTIONS] <PROPOSAL_ID> <CHOICE>

Arguments:
  <PROPOSAL_ID>
          The hex proposal id

  <CHOICE>
          `yes`, `no`, or `abstain`

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance statutes`

```text
List the statutes in force

Usage: rrn governance statutes [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance emergency-declare`

```text
Declare an emergency (ADR-0023): compresses the emergency-proposal window once a supermajority of the electorate co-signs. Signed by the station wallet, whose signature counts toward the threshold

Usage: rrn governance emergency-declare [OPTIONS] <REASON> <SCOPE>

Arguments:
  <REASON>
          The crisis, human-readable (testimony/display only)

  <SCOPE>
          The declared emergency domain (testimony/display only)

Options:
      --duration-secs <DURATION_SECS>
          Requested lifetime in seconds (clamped to [24h, 7d]; default 72h)

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --previous <PREVIOUS>
          The hex hash of the declaration this renews, if any (advisory)

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance emergency-cosign`

```text
Co-sign an emergency declaration (or a lapse), toward its supermajority

Usage: rrn governance emergency-cosign [OPTIONS] <DECLARATION_HASH>

Arguments:
  <DECLARATION_HASH>
          The hex declaration hash (for a lapse, the lapse's own hash)

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance emergency-lapse`

```text
Raise a lapse to end an active emergency early; it takes effect once its own co-signatures reach the supermajority. Prints the lapse hash to co-sign

Usage: rrn governance emergency-lapse [OPTIONS] <DECLARATION_HASH>

Arguments:
  <DECLARATION_HASH>
          The hex hash of the declaration whose emergency to end

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance emergency-status`

```text
Show the active emergency (if any) and the full derived timeline

Usage: rrn governance emergency-status [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn governance emergency-report`

```text
The post-emergency report: every activation, its co-signers, and the measures passed under it (ADR-0023 §6)

Usage: rrn governance emergency-report [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn dispute`

```text
Disputes: contest a confirmed payment, respond, rule as a juror, resolve (M1.10)

Usage: rrn dispute [OPTIONS] <COMMAND>

Commands:
  list      List the disputes currently frozen, with their live jury tally
  show      Show one dispute in full: grievance, responses, and the seated jury
  raise     Contest a confirmed transaction, freezing its settlement (station-signed)
  respond   File the station wallet's side of a live dispute (station-signed)
  rule      Cast the station wallet's juror verdict (must hold a live seat)
  resolve   Enact terminal outcomes and lapse expired disputes. With no `tx_id`, sweeps them all; with one, resolves just that dispute
  escalate  Escalate to the electorate because the jury cannot seat a panel (station-signed; the wallet must be a party). ADR-0014 §5
  appeal    Appeal a jury ruling to the electorate (station-signed; the wallet must be a party), suspending the ruling's enactment. ADR-0014 §5
  vote      Cast the station wallet's ballot in an open escalation (must be an eligible, non-party established member)
  help      Print this message or the help of the given subcommand(s)

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn dispute list`

```text
List the disputes currently frozen, with their live jury tally

Usage: rrn dispute list [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn dispute show`

```text
Show one dispute in full: grievance, responses, and the seated jury

Usage: rrn dispute show [OPTIONS] <TX_ID>

Arguments:
  <TX_ID>
          The hex id of the disputed transaction

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn dispute raise`

```text
Contest a confirmed transaction, freezing its settlement (station-signed)

Usage: rrn dispute raise [OPTIONS] <TX_ID> <REASON>

Arguments:
  <TX_ID>
          The hex id of the confirmed transaction to contest

  <REASON>
          A bounded statement of the grievance

Options:
      --evidence <EVIDENCE>
          Optional hex content hash of out-of-band evidence

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn dispute respond`

```text
File the station wallet's side of a live dispute (station-signed)

Usage: rrn dispute respond [OPTIONS] <TX_ID> <STATEMENT>

Arguments:
  <TX_ID>
          The hex id of the disputed transaction

  <STATEMENT>
          A bounded statement of your side

Options:
      --evidence <EVIDENCE>
          Optional hex content hash of out-of-band evidence

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn dispute rule`

```text
Cast the station wallet's juror verdict (must hold a live seat)

Usage: rrn dispute rule [OPTIONS] <TX_ID> <RULING>

Arguments:
  <TX_ID>
          The hex id of the disputed transaction

  <RULING>
          `uphold` (void the transfer) or `reject` (let it settle)

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn dispute resolve`

```text
Enact terminal outcomes and lapse expired disputes. With no `tx_id`, sweeps them all; with one, resolves just that dispute

Usage: rrn dispute resolve [OPTIONS] [TX_ID]

Arguments:
  [TX_ID]
          The hex id of a single disputed transaction to resolve

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn dispute escalate`

```text
Escalate to the electorate because the jury cannot seat a panel (station-signed; the wallet must be a party). ADR-0014 §5

Usage: rrn dispute escalate [OPTIONS] <TX_ID>

Arguments:
  <TX_ID>
          The hex id of the disputed transaction

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn dispute appeal`

```text
Appeal a jury ruling to the electorate (station-signed; the wallet must be a party), suspending the ruling's enactment. ADR-0014 §5

Usage: rrn dispute appeal [OPTIONS] <TX_ID>

Arguments:
  <TX_ID>
          The hex id of the disputed transaction

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn dispute vote`

```text
Cast the station wallet's ballot in an open escalation (must be an eligible, non-party established member)

Usage: rrn dispute vote [OPTIONS] <TX_ID> <RULING>

Arguments:
  <TX_ID>
          The hex id of the escalated transaction

  <RULING>
          `uphold` (void the transfer) or `reject` (let it settle)

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn cert`

```text
Offline spending certificates: reserve debt-floor headroom before a partition, and list your outstanding certificates (M2.3, ADR-0021)

Usage: rrn cert [OPTIONS] <COMMAND>

Commands:
  request  Reserve a headroom certificate for your own wallet, ahead of going offline. Its cap is held against your debt-floor headroom until it expires or you return it
  list     List outstanding certificates (defaults to your own)
  help     Print this message or the help of the given subcommand(s)

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn cert request`

```text
Reserve a headroom certificate for your own wallet, ahead of going offline. Its cap is held against your debt-floor headroom until it expires or you return it

Usage: rrn cert request [OPTIONS] <CAP>

Arguments:
  <CAP>
          Cap to reserve, in Commons, e.g. `10` or `2.50`

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn cert list`

```text
List outstanding certificates (defaults to your own)

Usage: rrn cert list [OPTIONS] [ADDRESS]

Arguments:
  [ADDRESS]
          The `rrn1…` address to query; omitted means your own

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn paper`

```text
Paper fallback: export payloads to printable QR sheets and ingest scanned QR text (M2.5, ADR-0020 §3 / ADR-0021 §4). The CLI consumes scanned QR *text* — one payload string per line, from any scanner app — it does not read camera images. A member exporting their *own* signed records prints them with `rrn wallet export` (ADR-0028); these tools are the courier's

Usage: rrn paper [OPTIONS] <COMMAND>

Commands:
  show             Classify and pretty-print any paper payload(s) without ingesting them — the courier's inspection path. Verifies every signature it can and reports missing chunks for incomplete multi-part groups. Needs no station
  ingest           Reassemble scanned QR text, submit carried bundles to the station, and print each record's outcome. Re-ingesting the same input is idempotent
  export-receipts  Fetch pending delivery receipts and render them for a courier to carry back to their authors (the carry-back leg). Fetching never confirms delivery — only the author's own device does
  cert             Print a headroom-certificate wallet card: an existing certificate (by id) or one requested now, as an `rrncert:` QR with member, cap, and expiry
  credential       Print a member credential card: the member's bare address QR (qr-payloads §1 — no new format) with an optional name
  render           Render already-encoded QR-text lines to a printable sheet: one `chunk_NN_of_MM.png` per line plus a captioned `sheet.pdf`. The shared print primitive (what `export-receipts` uses internally)
  help             Print this message or the help of the given subcommand(s)

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn paper show`

```text
Classify and pretty-print any paper payload(s) without ingesting them — the courier's inspection path. Verifies every signature it can and reports missing chunks for incomplete multi-part groups. Needs no station

Usage: rrn paper show [OPTIONS] --in <INPUT>

Options:
      --in <INPUT>
          Files of QR-text lines (one payload string per line). Repeatable

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn paper ingest`

```text
Reassemble scanned QR text, submit carried bundles to the station, and print each record's outcome. Re-ingesting the same input is idempotent

Usage: rrn paper ingest [OPTIONS] --in <INPUT>

Options:
      --in <INPUT>
          Files of QR-text lines (one payload string per line). Repeatable

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --out <OUT>
          Write the station's delivery receipts here (as `receipts.txt` + QR sheet) for the carry-back leg

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn paper export-receipts`

```text
Fetch pending delivery receipts and render them for a courier to carry back to their authors (the carry-back leg). Fetching never confirms delivery — only the author's own device does

Usage: rrn paper export-receipts [OPTIONS] --out <OUT>

Options:
      --out <OUT>
          Where to write `receipts.txt` and the QR sheet

      --socket <SOCKET>
          Path to the station's Unix socket

      --author <AUTHORS>
          Restrict to receipts for these `rrn1…` authors. Repeatable; omit for the whole pending queue

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

      --since <SINCE>
          Only receipts for records admitted at/after this admission-clock time

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn paper cert`

```text
Print a headroom-certificate wallet card: an existing certificate (by id) or one requested now, as an `rrncert:` QR with member, cap, and expiry

Usage: rrn paper cert [OPTIONS] --out <OUT>

Options:
      --out <OUT>
          Where to write the card (PDF + PNG)

      --socket <SOCKET>
          Path to the station's Unix socket

      --cert-id <CERT_ID>
          Export an existing certificate by its hex content id

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

      --request <REQUEST>
          Reserve a new certificate for this cap (Commons, e.g. `10`) and export it

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn paper credential`

```text
Print a member credential card: the member's bare address QR (qr-payloads §1 — no new format) with an optional name

Usage: rrn paper credential [OPTIONS] --out <OUT> --address <ADDRESS>

Options:
      --out <OUT>
          Where to write the card (PDF + PNG)

      --socket <SOCKET>
          Path to the station's Unix socket

      --address <ADDRESS>
          The member's `rrn1…` address

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

      --name <NAME>
          A human name to caption the card with

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn paper render`

```text
Render already-encoded QR-text lines to a printable sheet: one `chunk_NN_of_MM.png` per line plus a captioned `sheet.pdf`. The shared print primitive (what `export-receipts` uses internally)

Usage: rrn paper render [OPTIONS] --in <INPUT> --out <OUT>

Options:
      --in <INPUT>
          A file of QR-text lines to render

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --out <OUT>
          Where to write the PNGs and `sheet.pdf`

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn dtn`

```text
Delay-tolerant networking: originate an outbound bundle push to a peer over the Reticulum transport, inspect tracked pushes, and publish this station's own reachability binding (M2.6, ADR-0013/0020)

Usage: rrn dtn [OPTIONS] <COMMAND>

Commands:
  push    Push a bundle file to a peer over the DTN transport. Returns a queued acknowledgement — delivery is confirmed later by the peer's receipt (watch `rrn dtn status`)
  status  List tracked outbound pushes: peer, records, state, attempts, and the correlated receipt's outcome summary
  bind    Publish this station's own transport binding at a Reticulum destination hex, and print the signed binding envelope to carry to peers
  help    Print this message or the help of the given subcommand(s)

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn dtn push`

```text
Push a bundle file to a peer over the DTN transport. Returns a queued acknowledgement — delivery is confirmed later by the peer's receipt (watch `rrn dtn status`)

Usage: rrn dtn push [OPTIONS] --peer <PEER> --bundle <BUNDLE>

Options:
      --peer <PEER>
          The peer: an `rrn1…` address (resolved via the binding directory) or a bare Reticulum destination hex

      --socket <SOCKET>
          Path to the station's Unix socket

      --bundle <BUNDLE>
          Path to a bundle file (encoded bytes), e.g. one produced by the paper tooling

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn dtn status`

```text
List tracked outbound pushes: peer, records, state, attempts, and the correlated receipt's outcome summary

Usage: rrn dtn status [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn dtn bind`

```text
Publish this station's own transport binding at a Reticulum destination hex, and print the signed binding envelope to carry to peers

Usage: rrn dtn bind [OPTIONS] --destination <DESTINATION>

Options:
      --destination <DESTINATION>
          The Reticulum destination hex this station is reachable at

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

### `rrn wallet`

```text
The self-custody member wallet (ADR-0028): hold your own key on a computer with no phone, sign payments offline into a durable outbox, carry them on paper or a DTN bundle, and pair/sync over the sealed channel when online

Usage: rrn wallet [OPTIONS] <COMMAND>

Commands:
  init          Create a new member wallet (or restore a backed-up one) pinned to a station
  pair          Pair with the station over the sealed channel; prints the SAS for the operator to confirm
  sync          Re-anchor and sync: nonce, outbox head, balance, and delivery receipts
  status        Show local wallet state — never unlocks the key
  pay           Sign a payment: chained into the outbox, pending until submitted/carried
  confirm       Confirm a proposed payment addressed to you
  vote          Cast a governance ballot
  dispute       Contest a confirmed payment
  vouch         Vouch for another member (online only — needs the station reachable)
  cert          Headroom certificates (ADR-0021): request, import, list, return
  export        Export pending outbox entries as QR sheets or a raw bundle (offline path)
  submit        Submit pending entries online: bundle → channel → apply receipts
  receipts      Delivery receipts
  show          Show local outbox rows and their dispositions
  transactions  Your transactions, read live from the station over the channel
  help          Print this message or the help of the given subcommand(s)

Options:
      --home <HOME>
          The wallet home directory (else `$RRN_WALLET_HOME`, else `$HOME/.railroad/wallet`)

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet init`

```text
Create a new member wallet (or restore a backed-up one) pinned to a station

Usage: rrn wallet init [OPTIONS] --station <STATION>

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --station <STATION>
          The station's `rrn1…` address to pin (learned from the operator, in person — the pin is the security boundary)

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --restore <RESTORE>
          Restore from a backed-up `member.rrnwallet` instead of a fresh key. The restored wallet refuses signing until one `sync` re-anchors it

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet pair`

```text
Pair with the station over the sealed channel; prints the SAS for the operator to confirm

Usage: rrn wallet pair [OPTIONS] --url <URL>

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --url <URL>
          The station's mobile listener, `host:port`

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet sync`

```text
Re-anchor and sync: nonce, outbox head, balance, and delivery receipts

Usage: rrn wallet sync [OPTIONS]

Options:
      --no-receipts
          Skip fetching and applying delivery receipts

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet status`

```text
Show local wallet state — never unlocks the key

Usage: rrn wallet status [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet pay`

```text
Sign a payment: chained into the outbox, pending until submitted/carried

Usage: rrn wallet pay [OPTIONS] <RECEIVER> <AMOUNT>

Arguments:
  <RECEIVER>
          The receiver's `rrn1…` address

  <AMOUNT>
          Amount in Commons, e.g. `3`, `3.5`, or `3.50`

Options:
      --memo <MEMO>
          Optional memo recorded in the signed proposal

      --socket <SOCKET>
          Path to the station's Unix socket

      --cert <CERT>
          Spend against a held headroom certificate (id hex or prefix)

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

      --expires-in <EXPIRES_IN>
          Override the proposal's validity window, in seconds

      --carrier <CARRIER>
          The carrier this spend is bound for (sets the default expiry)

          Possible values:
          - fast: Online submit or a same-day courier: the normal 24h proposal TTL
          - slow: Paper / LoRa / SMS: a two-week window so the record survives delivery
          
          [default: fast]

      --voucher-out <VOUCHER_OUT>
          Also write `rrnspend:` voucher lines for offline verification

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet confirm`

```text
Confirm a proposed payment addressed to you

Usage: rrn wallet confirm [OPTIONS] <TX_ID>

Arguments:
  <TX_ID>
          The hex transaction id

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet vote`

```text
Cast a governance ballot

Usage: rrn wallet vote [OPTIONS] <PROPOSAL_ID> <CHOICE>

Arguments:
  <PROPOSAL_ID>
          The proposal id, hex

  <CHOICE>
          yes | no | abstain
          
          [possible values: yes, no, abstain]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet dispute`

```text
Contest a confirmed payment

Usage: rrn wallet dispute [OPTIONS] --reason <REASON> <TX_ID>

Arguments:
  <TX_ID>
          The hex transaction id

Options:
      --reason <REASON>
          A bounded free-text statement of the grievance

      --socket <SOCKET>
          Path to the station's Unix socket

      --evidence-hash <EVIDENCE_HASH>
          Optional content hash of out-of-band evidence (hex)

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet vouch`

```text
Vouch for another member (online only — needs the station reachable)

Usage: rrn wallet vouch [OPTIONS] --statement <STATEMENT> --stake <STAKE> <ADDRESS>

Arguments:
  <ADDRESS>
          The `rrn1…` address to vouch for

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --statement <STATEMENT>
          The attestation statement

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --stake <STAKE>
          The reputation stake, in Commons

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet cert`

```text
Headroom certificates (ADR-0021): request, import, list, return

Usage: rrn wallet cert [OPTIONS] <COMMAND>

Commands:
  request  Request a headroom certificate (online round-trip)
  import   Import a certificate from an `rrncert:` line or raw envelope file
  list     List certificates the wallet holds
  return   Return an outstanding certificate early (chained record)
  help     Print this message or the help of the given subcommand(s)

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet export`

```text
Export pending outbox entries as QR sheets or a raw bundle (offline path).

The encoding is a positional argument (`qr` or `bundle`): the global `--format json|text` already owns `--format`, so this cannot reuse it.

Usage: rrn wallet export [OPTIONS] --out <OUT> <ENCODING>

Arguments:
  <ENCODING>
          `qr` (printable sheets) or `bundle` (raw `payload.bundle`)

          Possible values:
          - qr:     Printable QR sheets (`rrnp:` chunks + PNG + PDF), for `rrn paper ingest`
          - bundle: A single `payload.bundle` of raw bytes, for `rrn dtn push --bundle`

Options:
      --out <OUT>
          The output directory

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --max-entries <MAX_ENTRIES>
          Cap the number of pending entries carried

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet submit`

```text
Submit pending entries online: bundle → channel → apply receipts

Usage: rrn wallet submit [OPTIONS]

Options:
      --max-entries <MAX_ENTRIES>
          Cap the number of pending entries submitted in one bundle

      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet receipts`

```text
Delivery receipts

Usage: rrn wallet receipts [OPTIONS] <COMMAND>

Commands:
  apply  Apply station-signed receipts from scanned QR text or raw bytes
  help   Print this message or the help of the given subcommand(s)

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet show`

```text
Show local outbox rows and their dispositions

Usage: rrn wallet show [OPTIONS]

Options:
      --pending
          Only still-pending rows

      --socket <SOCKET>
          Path to the station's Unix socket

      --all
          Every row, acked and pending (the default shows pending + recent)

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```

#### `rrn wallet transactions`

```text
Your transactions, read live from the station over the channel

Usage: rrn wallet transactions [OPTIONS]

Options:
      --socket <SOCKET>
          Path to the station's Unix socket

      --format <FORMAT>
          Output format

          Possible values:
          - text: Terse, human/grep-friendly lines
          - json: One-line JSON for piping
          
          [default: text]

      --color <COLOR>
          Colorize text output. Off unless asked for

          Possible values:
          - never:  No escape codes, ever
          - always: Colorize, whatever stdout is attached to
          
          [default: never]

  -h, --help
          Print help (see a summary with '-h')
```
