# Troubleshooting

Symptom first, then the likely cause, then the fix. Grouped by where the
problem shows up. The three commands that answer most questions from the
station's console:

```sh
rrn whoami      # the station is up and this is its address
rrn status      # connectivity: role, peers, the phone listener, pending queues, the sidecar
rrn history     # the log; the last entries tell you what actually landed
```

`rrn status` reports the station's **role** (writer or replica), whether the
phone listener bound and is advertised, how many delivery receipts are waiting
for a courier, and the radio sidecar's state: `disabled`, `running` with its
version, `degraded` with a reason, or `restarting`.

## Pairing and discovery

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| The phone's Join screen finds no station | Phone on a guest or other Wi-Fi. | Same real network as the station. Guest networks isolate clients. |
| | The network blocks mDNS, or `advertise = false`. | On the phone, *Add by address* with the station's IP and port 7500. |
| | The station is down. | `rrn whoami` on the station machine. Start it. |
| *Add by address* fails too | Firewall on the station machine. | Allow inbound TCP 7500 from the LAN. Port 7400 stays closed. |
| | Wrong IP. | Check the router, or `ip addr` on the station. |
| | The listener did not bind. | `rrn status` shows the mobile listener as unbound. Another process holds port 7500, or `[mobile] listen` is wrong. |
| Pairing codes do not match | Something else answered in the station's place. | **Do not pair.** Identify the machine that owns that IP before pairing anyone. |
| The app says the station "couldn't be verified" | Same as above: the endpoint cannot prove it holds the station key. | Refuse. |
| `station pair-mobile` lists nothing | The phone has not sent its request yet, or sent it to a different machine. | Have the member tap Join again while you watch. |
| A wallet on a laptop refuses a receipt or a pairing reply | The address pinned at `rrn wallet init` is not this station's. | Compare `rrn whoami` with what the member typed. A wrong pin means a fresh `init`. |

See [Pair phones and wallets](pair-phones-and-wallets.md).

## Sync and notifications

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| No notifications while the app is closed | Battery optimisation, or *Sync while the app is closed* is off. | The three-step setup in [Keeping phones in sync](keeping-phones-in-sync.md). |
| Phone quiet for days, then a flood when opened | The vendor's app-killer is suppressing wakes. | The per-vendor table on that page. |
| Phone quiet overnight on a shelf, current when picked up | Wi-Fi sleeps and the phone falls back to mobile data. | A "keep Wi-Fi on during sleep" setting. |
| A previously fine phone goes quiet | An OS update or a "battery review" reset the exemption. | Re-walk the setup. |
| A **Connecting…** pill on cold start | Normal: the app is re-establishing its subscription. | Wait a second. |
| **Offline** that persists on the right Wi-Fi | The station is unreachable from the phone. | Work the pairing table above. |
| The member force-stopped the app "to fix it" | Force-stop disables all background wakes until the app is opened. | Open the app. Tell them not to. |
| Nothing appears even in the foreground | Not a background problem at all. | Pairing and Wi-Fi, above. |

## Payments and refusals

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| A payment is refused with a debt-floor message | It would take the payer below the floor, counting what they have already signed. | Wait for something to settle, or the payer sells something. The floor is a community setting, not a personal one. |
| A payment of 50 Commons or more is refused | Tier 3 is not served. Refused, never shrunk. | Split it into smaller payments over time. |
| A confirmed payment sits as pending for a day or two | The settlement window. Normal. | Nothing. Tier 1 settles after 24 hours, Tier 2 after 48. |
| A payment never settles | Someone contested it. | `rrn dispute list`. Every path resolves or lapses on its own. |
| A vouch is refused with a velocity message | The rate limit on how fast anyone can vouch or gain standing. | Wait. It is not personal. |
| A paper or bundle record is refused `nonce-gap` | An earlier record from that device has not arrived. Records land in order. | Wait for it, or have the member re-send. Re-ingest afterwards. |
| Refused `bad-signature` | A scan error, a corrupted line, or tampering. | Re-scan. If it persists the sheet is not what the member printed. |
| Refused `outbox-fork` | The member's device signed two different records at the same position, usually a restored wallet that did not sync first. | The member's standing is gone by rule. Prevent it: a restored wallet must `rrn wallet sync` before signing. |
| Refused `cert-overspent` | The same certificate was spent past its cap. | Recorded as equivocation. Costs the payer their whole standing and opens a jury case. |
| Refused `read-replica` | This station is a replica, not the writer. | Carry the record to the writer. A replica admits nothing. |
| Refused `tier-unsupported` | A carried record asked for a tier the station does not serve. | Same as the 50-Common case. |

Every refusal names its reason, and every admitted record earns a signed
receipt. See [The courier desk](courier-desk.md) for the full table.

## Station and daemon

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| `station run` rejects the passphrase | It wants the *wallet* passphrase from `station init`, not the machine login. | Lost it? [Key recovery](backups-and-key-recovery.md), today. |
| The daemon refuses to start with peers configured | A writer never pulls, so a writer with a non-empty `[peers]` list refuses to run. | Remove the peers, or set `role = "replica"` if this really is a read-only copy. |
| `rrn` says it cannot connect | The daemon is not running, or `--socket` points elsewhere. | Start the daemon; check the data directory. |
| Balances read zero on a replica | Expected: a replica cannot re-derive station-signed records under its own key. It is a copy of the chain for audit, not a balance oracle. | Read balances on the writer. |
| Shutdown hangs when a peer is configured by hostname | Name resolution on a dead resolver cannot be cancelled. | Configure peers by IP. |
| Sweeps seem late (settlement, contract charges, enactments) | The background timers run on coarse intervals: thirty seconds for settlement, minutes to an hour for the rest. | Normal. See the timers in the [configuration reference](../reference/configuration.md). |
| Nothing settles, no window runs | The station is the one writer. While it is down, nothing moves. | Bring it back. Members' signed records are preserved in their outboxes. |
| A member's app crashed | Every error is recorded on the phone and survives restarts. | Ask for Settings → Advanced → **Diagnostics**, which has a copy button. The crash screen offers the same. |

## Offline carriers

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| A sheet will not reassemble | A chunk is missing, or two payloads' sheets are mixed. | `rrn paper show --in scanned.txt` names the missing indexes. Re-scan the whole set. |
| The same sheet ingested twice | Nothing wrong. | The station returns the same receipts; nothing double-counts. |
| A member never got their receipt | The receipt is waiting at the station. | `rrn paper export-receipts --author <addr>`; exporting twice is safe. |
| `rrn dtn status` shows a push `abandoned` | Retried for a week with no receipt back. | The peer was unreachable that whole time. Re-push, or send the bundle on paper. |
| The sidecar reads `degraded` | Usually a version mismatch: only `1.5.x` is accepted. | `rnsd --version`; reinstall pinned. The station keeps running without it. |
| The station runs but no radio interface appears | `[lora.rnode]` absent, or the generated Reticulum config predates it. | Set the section; delete the generated config so it is rewritten. See [Radio and text message](radio-and-sms.md). |
| No serial port, or permission denied | The user is not in the serial group. | `sudo usermod -aG dialout $USER`, log out and in. |
| Two radios see no path to each other | Frequency, bandwidth, or spreading factor differ. | They must match exactly on every node. |
| SMS does nothing though `[sms]` is enabled | There is no modem gateway yet. | Expected. SMS cannot be switched on today. |

## The encrypted profile

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| `station run` exits right after a reboot | The volume is locked. | `station status`, then `station unlock` with a quorum of holders. |
| A systemd unit crash-loops after a reboot | Same. `Restart=always` retries before anyone can run the ceremony. | Use `Restart=on-failure` and start the unit after the ceremony. Expected behaviour. |
| A holder's fingerprint does not match the console | Someone else is running a ceremony against your holders, or the holder scanned an old request. | **Stop.** Start a fresh `station unlock` and compare again. |
| A holder's phone says it is not holding a piece for this | They scanned a shard for a different key, or never scanned one. | `station vmk status` shows the real holder set. Re-issue with `station vmk refresh`. |
| `encrypt-in-place` refuses to run | The station is already encrypted. | A rotation is a fresh migration; see [Encrypted at rest](encrypted-at-rest.md). |
| The station starts in the encrypted profile on macOS | It will not: the profile refuses rather than serving plaintext. | Linux only. |
| A restored station lost its listen address and timers | The archive does not include the boot directory's `config.toml`. | Keep a copy with your backups. |

## When you are stuck

1. `rrn status --format json` and `rrn history` give the station's own account.
2. The member's Diagnostics screen gives the phone's.
3. The `station` repo's runbook, *Setting up a Railroad Network community*,
   has the long form of every procedure on this site.
4. If it looks like a bug, open an issue in the `station` or `mobile` repo
   with both accounts attached. A security problem goes to the
   [security policy](../project/security.md) instead, never a public issue.
