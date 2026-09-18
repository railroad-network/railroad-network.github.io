#!/usr/bin/env bash
# Regenerate the pages that mirror the station repo rather than being written
# by hand: the `rrn` and `station` command references (from `--help`) and the
# ADR index (from docs/adr/). Run from anywhere; commit the result.
#
#   STATION=/path/to/station scripts/gen-reference.sh
set -euo pipefail

HERE="$(cd "$(dirname "$0")/.." && pwd)"
STATION="${STATION:-$HERE/../station}"
STATION="$(cd "$STATION" && pwd)"
OUT="$HERE/src/reference"
ADR_BASE="https://github.com/railroad-network/station/blob/main/docs/adr"

if [[ ! -x "$STATION/target/debug/rrn" || ! -x "$STATION/target/debug/station" ]]; then
  echo "building rrn and station in $STATION ..." >&2
  (cd "$STATION" && cargo build -q -p rrn-cli -p rrn-station)
fi
RRN="$STATION/target/debug/rrn"
STATION_BIN="$STATION/target/debug/station"

# Print the subcommand names listed under "Commands:" in a --help output.
subcommands() {
  awk '/^Commands:/{f=1;next} f&&/^[[:space:]]*$/{exit} f{print $1}' | grep -vx help || true
}

# Emit one section per command, recursing one level into command groups.
# $1 = binary, $2 = heading level, $3.. = command path
emit() {
  local bin="$1" level="$2"; shift 2
  local hashes; hashes="$(printf '%*s' "$level" '' | tr ' ' '#')"
  local name; name="$(basename "$bin") $*"; name="${name% }"
  echo
  echo "$hashes \`$name\`"
  echo
  echo '```text'
  "$bin" "$@" --help
  echo '```'
  if (( level < 4 )); then
    local sub
    while read -r sub; do
      [[ -z "$sub" ]] && continue
      emit "$bin" $((level + 1)) "$@" "$sub"
    done < <("$bin" "$@" --help | subcommands)
  fi
}

gen_cli() {
  local bin="$1" file="$2" intro="$3"
  {
    echo "# \`$(basename "$bin")\` command reference"
    echo
    echo "$intro"
    echo
    echo "> **Generated page.** This is the \`--help\` text of every command, captured from a"
    echo "> build of the [\`station\`](https://github.com/railroad-network/station) repo"
    echo "> by \`scripts/gen-reference.sh\`. Edit the help strings there, not this file."
    emit "$bin" 2
  } > "$file"
  echo "wrote $file" >&2
}

gen_cli "$RRN" "$OUT/cli/rrn.md" \
  "\`rrn\` is the command-line client. It is three things in one binary: the operator's console for a running station, the verify-only paper courier tools, and the self-custody member wallet for people who use a computer instead of a phone."

gen_cli "$STATION_BIN" "$OUT/cli/station.md" \
  "\`station\` is the daemon: it holds the community's wallet and log, runs settlement, talks to peers, and serves the \`rrn\` client over a Unix socket. Most of its subcommands are one-time or occasional operator tasks; \`station run\` is the long-running one."

{
  echo "# Architecture decision records"
  echo
  echo "Every locked design decision in Railroad Network is written down as an"
  echo "Architecture Decision Record (ADR) in the \`station\` repo. ADRs are"
  echo "append-only: a changed decision gets a new ADR that supersedes the old one."
  echo "When a page on this site and an ADR disagree, **the ADR wins**."
  echo
  echo "> **Phase numbering.** ADRs written before 2026-08-25 use the old phase"
  echo "> numbering, where \"Phase 2\" meant federation. ADR-0017 resequenced the"
  echo "> plan: Phase 2 is now single-community resilience and Phase 3 is federation."
  echo "> ADRs 0001 to 0016 keep the old numbering as written."
  echo
  echo "| ADR | Decision |"
  echo "| --- | --- |"
  for f in "$STATION"/docs/adr/0*.md; do
    b="$(basename "$f")"
    num="${b%%-*}"
    title="$(head -1 "$f" | sed -E 's/^# *//; s/^[0-9]{4} *[—-] *//')"
    echo "| [$num]($ADR_BASE/$b) | $title |"
  done
  echo
  echo "> **Generated page.** Built from \`docs/adr/\` in the \`station\` repo by"
  echo "> \`scripts/gen-reference.sh\`."
} > "$OUT/adrs.md"
echo "wrote $OUT/adrs.md" >&2
