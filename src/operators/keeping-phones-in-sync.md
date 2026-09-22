# Keeping phones in sync

A member's phone is only as useful as its last sync. With the app open it
holds a live connection to the station and everything is instant. The moment
it goes to the background, and more so once Android kills the process, the
phone is at the mercy of the operating system's power management. On many
phones the factory settings quietly starve the app: no notifications, stale
balances, members who miss vouches, payment confirmations, votes, and dispute
deadlines.

This page is for the operator onboarding members. It explains what the app
does in the background, the two in-app switches and one system setting every
phone needs, the vendor-specific traps, and how to verify a phone in ten
minutes. Do it at pairing time: it takes two minutes with the member present
and saves diagnosing a silent phone a week later.

## How background sync actually works

The app has three modes. Knowing which one a phone is in tells you what is
*normal*. Half of all "background sync is broken" reports are correct
behaviour with unset expectations.

**Foreground.** App open and unlocked. A live subscription to the station;
new events arrive within seconds. Nothing on this page affects this.

**Backgrounded.** App not on screen, process still alive. The app asks the
system to wake it periodically, **at minimum every fifteen minutes**, and the
system is free to space the wakes out further for an app it considers
unimportant. Each wake runs one short pass: connect, pull whatever queued
since the phone's last sync, raise a notification for each event the member
has asked about, sleep.

**Killed or rebooted.** Android eventually kills every backgrounded process,
and a reboot kills everything. The app registers a task that lets the system
wake it even then, without it appearing on screen. But a freshly woken
process has no unlocked wallet, and a sync request must be signed. So
killed-app sync **only works if the member has opted in to background sync**,
which provisions a special signing credential for the task.

Two things follow:

- Background sync is a **polling cadence, not a push channel**. "Within
  fifteen to thirty minutes" is healthy. "Instantly, in a pocket" was never
  on offer. Opening the app always syncs at once.
- **Every layer below can silently veto the wakes.** The rest of this page is
  about finding and disarming those vetoes.

## The per-phone setup

Three things, in order, on every member's phone.

**1. Allow notifications.** In the app, Settings → **Notifications**: enable
*Local notifications* and check the *Notify me about* list matches what the
member wants. On first run Android shows its own permission prompt; it must be
accepted. A declined prompt is fixed later under system Settings → Apps →
Railroad Network → Notifications.

**2. Turn on "Sync while the app is closed."** Same screen, under *Background
sync*. This is the switch that makes killed-app and after-reboot sync possible
at all. Flipping it does two things:

- The app provisions a **background signing credential**: the wallet is
  re-encrypted under a random device-held secret so the background task can
  sign sync requests without a passphrase. The trade is real and deliberate:
  while the *device* is unlocked, the app process can sign without the
  member's passphrase. It is opt-in and device-bound, and a member who
  declines simply gets no sync while the app is closed. That is a legitimate
  choice.
- The app immediately shows the system **battery-exemption dialog**. **The
  member should accept it.** On many phones (Motorola, verified first-hand in
  this project) the battery optimiser does not just slow a backgrounded app;
  it **cuts its network access entirely**. The wake fires, the pass runs, and
  the station is simply unreachable.

**3. Clear the vendor's own app-killer.** Stock Android's exemption is
necessary but on several brands not sufficient. Find the brand in the table
below.

If the dialog in step 2 was dismissed, the manual path is system Settings →
Apps → Railroad Network → Battery → **Unrestricted**. The wording varies:
"Don't optimize", "No restrictions", "Allow background activity".

## Per-vendor traps

Stock Android already throttles twice: deep sleep when the phone sits still,
and rarer wakes for rarely used apps. The exemption above handles those. On
top of that, most vendors ship their own battery manager that kills or freezes
apps by its own rules and ignores the stock exemption. Those produce the
"phone went quiet three days in" reports.

| Brand | Trap | What to set |
| --- | --- | --- |
| **Motorola** | The battery optimiser cuts background network on the LAN. | The step-2 dialog is usually enough: Battery → **Unrestricted**. |
| **Google Pixel** | Closest to stock; standby buckets still apply. | The step-2 exemption is enough. |
| **Samsung** | "Sleeping apps" and "deep sleeping apps" lists, plus *put unused apps to sleep*. Apps freeze after a few days of light use. | Settings → Battery → Background usage limits: remove the app from **Sleeping** and **Deep sleeping**, add it to **Never sleeping apps**; turn off *Put unused apps to sleep*. |
| **Xiaomi, Redmi, POCO (MIUI)** | The most aggressive: a separate Autostart permission, a per-app battery saver, and swipe-away kills the app by default. | Security app → Permissions → **Autostart: on**. Settings → Battery → App battery saver → Railroad Network → **No restrictions**. In Recents, drag the app down to **lock** it. |
| **Huawei, Honor (EMUI)** | "App launch" auto-manages apps and kills background tasks. | Settings → Battery → App launch → Railroad Network → **Manage manually**, enable all three: Auto-launch, Secondary launch, Run in background. |
| **OnePlus, Oppo, Realme, Vivo** | Battery optimisation plus a separate autostart or "quick freeze" layer. | Battery → **Don't optimize**; Settings → Apps → Autostart (or "Startup manager") → allow; disable any "sleep standby" or "quick freeze" entry for the app. |

Two gotchas on every brand:

- **Force-stop kills everything.** Settings → Apps → Force stop, and on some
  vendors swiping the app out of Recents, puts the app in a state where
  Android delivers **no** background wakes until the member opens it again. A
  member troubleshooting by force-stopping is disabling the thing they are
  testing. On the swipe-happy brands, use the Recents lock instead.
- **The trap resets.** OS updates, vendor "battery usage reviews", and the
  periodic "this app runs in the background" nudge can re-enable
  optimisation. If a previously fine phone goes quiet, re-walk the setup
  before suspecting anything else.

Vendors rename these screens constantly. The community-maintained
[dontkillmyapp.com](https://dontkillmyapp.com) has per-brand, per-version
walkthroughs with screenshots when the wording above has drifted.

## The network is part of "background"

A wake that fires on schedule still syncs nothing if the phone cannot reach
the station at that moment.

- **The station is on the local network only.** Away from the community's
  Wi-Fi there is nothing to sync; the phone catches up when it is back. This
  is by design. Do not chase it as a bug.
- **Wi-Fi sleep.** Some phones drop Wi-Fi minutes into deep sleep and lean on
  mobile data, which cannot reach the station. Symptom: quiet overnight on a
  shelf, instantly current when picked up. Look for a "keep Wi-Fi on during
  sleep" setting; some brands bundle it into the battery manager.
- **Guest or isolated Wi-Fi.** Client isolation blocks phone-to-station
  traffic entirely, in the foreground too, so it shows up at pairing time
  already. Members must be on the same real network as the station.

## The ten-minute drill

Run it once per phone at onboarding, and again whenever someone reports
silence. It separates a misconfigured phone from normal cadence in one pass.

1. **Setup check.** All three steps above done; the in-app Notifications
   screen shows background sync enabled.
2. **Background the app** with Home. Do not force-stop it, and do not swipe it
   away on MIUI-family phones. Screen off, phone on the community Wi-Fi.
3. **Queue an event from the station.** Anything addressed to that member
   works; a vouch is the classic:

   ```sh
   rrn vouch <member-rrn1-address> --statement "background sync drill"
   ```

4. **Wait up to thirty minutes**: one wake at the fifteen-minute floor plus
   system slack. A notification arriving means the backgrounded path works.
5. **The killed-app path, once per phone model.** Reboot the phone, do *not*
   open the app, queue another event, wait again. A notification on a locked
   phone never opened since boot proves the whole chain.
6. **Log the result.** Keep a roster note per phone: brand and model, date
   verified, which settings it needed beyond stock. The next phone of the
   same model onboards in a minute.

If step 4 or 5 fails, work the vendor table and the network checks for that
brand, then re-run. For a phone that still fails, have the member open the
app. A backlog of missed notifications appearing at once means wakes are being
suppressed: keep digging in the vendor's battery manager. Nothing appearing
even in the foreground means it is not a background problem at all: check
pairing and Wi-Fi in [Troubleshooting](troubleshooting.md).

## Setting member expectations

Tell members plainly, once, at onboarding:

- Notifications while the app is closed arrive in **batches, up to half an
  hour behind**. That is the platform, not a fault. For anything
  time-critical, such as a dispute window closing, open the app.
- **Off the community Wi-Fi you are offline.** The app catches up when you
  are back in range.
- **Do not force-stop the app** or swipe it away to save battery. It costs
  almost nothing, and killing it turns off your notifications until you next
  open it.
- If your phone ever asks about the app "running in the background" or "using
  battery", answer **Allow** or **Keep**. The optimisation it offers is what
  breaks your notifications.

## iPhones, for completeness

The pilot fleet is Android. On iOS the same sync code runs under Background
App Refresh: no vendor app-killer zoo and no background network firewall, but
the system grants wakes purely opportunistically, with no fifteen-minute
floor, no boot wake, and no exemption to request. Cadence is noticeably lazier
and nothing here can improve it. Foreground behaviour is identical.

## The one-glance checklist, per phone

- [ ] Notification permission accepted; *Local notifications* on
- [ ] *Sync while the app is closed* on, and the member understood the trade
- [ ] Battery → **Unrestricted** (the in-app dialog accepted)
- [ ] Vendor trap cleared: Samsung sleep lists, MIUI autostart and lock, EMUI app launch, ColorOS autostart
- [ ] Phone on the real community Wi-Fi, not a guest network
- [ ] Drill passed: backgrounded notification
- [ ] Drill passed once per model: post-reboot notification
- [ ] Roster note written
