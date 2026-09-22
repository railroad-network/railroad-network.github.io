# Back up and recover your keys

Your identity is a key on your phone. Your balance, your standing, your
history, and your vote all hang off it. There is no "forgot password" link,
because there is no company holding a copy. This page walks through, step by
step, what the app gives you instead: a passphrase, a **recovery circle** of
friends who each hold a sealed piece of your key, and an export you can carry
to another device.

> **Both backups work end to end.** A recovery circle rebuilds your key on a
> new phone or laptop from your holders; an export restores it from a file you
> kept. Set up the circle in your first weeks and do the export too. Neither
> can be set up *after* the phone is gone.

## What you are protecting

Two things, and they are different:

- **Your key.** Generated on your phone when you created the wallet. It is
  your identity. Lose every copy and the identity is gone.
- **Your passphrase.** Encrypts the key on the phone. Fingerprint or face
  unlock sits on top of it as a convenience; you still need the passphrase
  after a restart, to export, and to help a friend recover.

A backup here means a second way to get the **key** back. Nothing on this
page backs up the passphrase. Write it down, on paper, and keep it somewhere
that is not your phone.

## The idea behind the circle

The app splits your key into pieces, called **shards**, and hands one to each
of several people you trust. The scheme is called **Shamir's secret sharing**,
and it has one property worth understanding: any **three** shards, brought
together, rebuild the key exactly, and any **two** reveal nothing at all. Not
a little. Nothing. Two holders colluding learn as much about your key as two
strangers, because of the mathematics, not because of a server or a rule.

Some facts about how the app does it:

- The split happens **on your phone, offline**. Nothing is uploaded.
- The threshold is fixed at **3**. You choose between **3 and 7** holders; the
  app recommends 5.
- Each shard is **sealed to its holder** before it leaves your phone. A photo
  of the QR code is useless to anyone but that holder, and even that holder
  has only one piece.
- Holders cannot act alone, cannot see your key, and cannot combine pieces
  without you asking them to.

The project wrote its own implementation of the scheme rather than depend on
a library. The reasoning is in
[ADR-0004](https://github.com/railroad-network/station/blob/main/docs/adr/0004-own-shamir-implementation.md).

## Walkthrough: set up your recovery circle

Do this in the first week or two, once there are a few members you trust. It
takes fifteen minutes and needs your holders in the room.

**Before you start.** Pick your holders. Each must already have the app and a
wallet, and each needs to be physically present, one at a time. See
[Choosing holders](#choosing-holders) below.

1. **Open the setup.** On the Home screen the app nudges you with **Protect
   your account** and a **Set up recovery** button. Later, it is under
   Settings → **Social recovery**.
2. **Confirm it's you.** Enter your passphrase. The app needs the key
   unlocked to split it.
3. **Read the intro.** "Your circle holds the key" explains the three
   promises: any 3 can bring you back, no single one can, and nothing is
   uploaded. Tap **Choose my circle**.
4. **Choose your circle.** Add each holder by scanning the address QR from
   their app (Settings → Your address) or pasting it. You can give each one a
   nickname; it stays on your phone. The app refuses your own address and
   duplicates, and needs at least 3. The counter reads "N chosen · any 3 can
   restore".
5. **Split.** Tap **Split my key into N pieces**. This takes a moment and
   happens entirely on the device.
6. **Hand out the shards.** The app shows **one holder's QR at a time**. For
   each holder, in person:
   - The holder opens Settings → **Shards you hold** and scans your screen.
   - Their app checks the shard is addressed to them and reports "You're now
     holding a recovery piece."
   - You tap **Scanned**, then **Next holder**.
7. **Finish.** Once at least 3 are marked scanned, **Finish** unlocks. If some
   holders are not present you can tap **Finish — distribute the rest later**
   and come back; the remaining shards stay on your phone until delivered.
8. **Done.** "Your circle has you" shows the shape, for example "5-holder
   circle · 3-of-5 to restore".

> **Tap Scanned only when the holder's phone actually confirmed it.** The app
> takes your word for it. A holder you marked but who never received the
> shard is a hole in your circle you will not discover until you need it.

### Choosing holders

- **People who will still be around.** A circle of five is a bet that at
  least three of them will be reachable, with their phones, when you need
  them. Choose across households and friend groups, not one family.
- **People who keep their phones.** A holder who wipes or loses their phone
  loses your shard with it. Ask holders to tell you if that happens, and
  re-run setup.
- **Not all founders, not all one clique.** The circle is a social graph
  that lives on your phone. It is not secret, but it should not be a single
  point of pressure either.
- **Five is a good number.** Three of five tolerates two absences. Seven is
  the maximum and rarely needed.

### Changing your circle

Settings → Social recovery → **Update my circle** runs the same steps again
with a new list. Your identity and address do not change. **Every old shard
stops working** the moment you split again, so re-hand-out to everyone, not
just the new people.

## Walkthrough: hold a shard for someone

You may be asked to be in a friend's circle. It costs you nothing until the
day they need you.

1. **Be there when they split.** They will show you one QR code.
2. Open Settings → **Shards you hold** and scan it. The app accepts only a
   real recovery shard, and only one addressed to you. A plain address or any
   other QR is rejected with an explanation.
3. The app confirms: "You're now holding a recovery piece. If your friend
   ever needs it, any 3 of their N holders can bring them back."
4. **Keep your phone and your wallet.** The shard lives inside your wallet's
   secure storage. If you change phones or reset, it is gone; tell your
   friend so they can re-run setup.
5. **Do not forget a shard** (the "Forget" action on that screen) unless the
   owner has told you they re-split and yours is dead.

You cannot read the shard, and nobody can make you hand it over without your
passphrase. Holding one for someone is safe.

## Walkthrough: help someone recover

When someone whose shard you hold runs a recovery ceremony, they will ask you
to contribute your piece. The ceremony runs on the requester's own device: a
member's new phone or laptop, or the station console for the station's key or
its encrypted volume. Whichever it is, it shows a **request QR** and a
**ceremony fingerprint**.

1. Open Settings → Shards you hold → **Help someone recover**.
2. **Scan the request** the station is showing. The app checks that you
   actually hold a piece for the identity the request names; if not, it says
   so and stops.
3. **Confirm.** The app shows the address being recovered and the **ceremony
   fingerprint**. **Read the fingerprint aloud and check it matches the one on
   the requester's screen.** The request itself carries no proof of who is
   asking; the matching fingerprint, between people who know each other, is
   that proof. A mismatch means someone else is running a ceremony with this
   address: stop.
4. **Enter your passphrase.** Your phone opens your sealed piece and re-seals
   it to this one ceremony.
5. **Show this to your friend.** The app displays a **response QR**. The
   person running the ceremony scans it. The response is useless to anyone
   else and for any other ceremony, so if you truly cannot attend, it is
   acceptable to relay the response over a chat, provided you have confirmed
   the fingerprint with the requester by voice first.

## Walkthrough: rebuild your key on a new phone

Your phone is gone. You have a new one, the app installed, and at least three
of your holders reachable, with their phones. Reconstruction happens
**entirely on your new device**; the station never sees your key and cannot
help or hinder.

1. **Tell the operator first** if the old phone was stolen rather than lost.
   They unpair it so a thief cannot keep syncing under your name. Do this
   before step 2.
2. On the new phone, at the welcome screen, tap **Recover an existing
   identity**, then **From my recovery circle**.
3. **Type your address**, the `rrn1…` string. Read it off your credential
   card, a friend's contact list, or the community list on someone else's
   phone. The app checks it is an address.
4. The app mints a fresh ceremony and shows a **request QR** and, under it, a
   short **ceremony fingerprint** in large type. Every holder must see this
   same fingerprint.
5. **Each holder, in person:** opens Settings → Shards you hold → **Help
   someone recover**, scans your request, and their phone shows the address
   being recovered and the same fingerprint. **They read the fingerprint
   aloud and you confirm it matches yours.** If it does not, stop: someone
   else is running a ceremony with your address. They enter their passphrase
   and their phone shows a **response QR**.
6. **Scan each response.** The app counts pieces gathered. A response from a
   different ceremony or a stale circle is rejected with an explanation. If
   you have a piece from everyone and it still will not rebuild, one holder
   has a shard from an older split; start over with a fresh request.
7. When three responses are in, your key is rebuilt. Choose a **new
   passphrase**, optionally set up fingerprint or face unlock, and
   **re-pair** with the station as on your first day. Your address, balance,
   standing, and history are exactly as they were.

Leaving the screen part way discards the gathered pieces, and your holders
would have to scan a fresh request; finish in one sitting.

> **Why the fingerprint.** A recovery request carries no proof of who is
> asking. The fingerprint, read aloud between people who know each other, is
> that proof. A holder who skips it can be tricked into helping a stranger
> rebuild your key. The design is in
> [ADR-0016](https://github.com/railroad-network/station/blob/main/docs/adr/0016-station-backup-and-key-recovery.md).

**On a laptop instead:** `rrn wallet recover --station <station> --address <yours>`
runs the same ceremony from a terminal, printing the request QR and the
fingerprint and reading the pasted responses. See
[Using a computer instead of a phone](using-a-computer.md).

**The station's own key** is protected the same way, with members as
holders; the operator's side is
[Backups and key recovery](../operators/backups-and-key-recovery.md).

## Walkthrough: export your wallet

The export is your encrypted key, in the same sealed format the wallet keeps
on disk. It is useless without your passphrase, and with your passphrase it
*is* you.

1. Settings → **Export wallet**. Enter your passphrase.
2. The app shows a block of text and a **Copy to clipboard** button. The
   banner says it exactly: "Anyone with this file and your passphrase is
   you."
3. **Move it directly to where it will live**, then clear your clipboard and
   delete any copies along the way. Good homes: a password manager entry, an
   encrypted drive, a file on a laptop with full-disk encryption. A bad home:
   a chat thread, an email to yourself, a cloud drive that syncs to every
   device you own.
4. **Keep the passphrase with it, but not in the same place.** The export
   without the passphrase is a brick. The two together are your identity.

Repeat the export after you change your passphrase; an old export answers
only to the old one.

### Restoring from an export

**On a new phone:** at the welcome screen tap **Recover an existing
identity**, then **From an exported wallet**, paste the exported text, enter
the export's passphrase, then choose a new device passphrase and re-pair.

**On a laptop**, into the command-line wallet:

```sh
# 1. Turn the exported text back into the wallet file.
base64 -d exported.txt > member.rrnwallet

# 2. Restore it, pinned to your community's station. You will set a
#    passphrase for this copy and be asked for the export's passphrase.
rrn wallet init --station rrn1<your-station-address> --restore member.rrnwallet

# 3. Re-anchor before signing anything. The restored wallet refuses to
#    sign until it has synced once from the station's network.
rrn wallet sync
```

The re-anchor step is not optional. A restored wallet does not know how far
its own history got, and signing before it finds out would look to the
station like a forked identity, which costs your whole standing. The app does
the same on its first sync after a restore.

> **Rehearse this once**, on a laptop, while your phone still works. A backup
> you have never restored is a hope, not a plan.

## If your phone is lost or stolen

1. **Tell the operator.** They **unpair** the old phone so it can no longer
   sync. The key on it is still encrypted under your passphrase; a thief
   needs that to use it.
2. **Rebuild on a new phone** from your circle or your export, as above,
   then re-pair. Your identity carries over intact.
3. **Do not create a fresh wallet** on the new phone hoping to merge later;
   you cannot. A fresh wallet is a new identity starting from zero.

## Housekeeping that matters

- **Updates:** install a newer app over the old one. **Never uninstall
  first**; that erases the wallet on the phone.
- **Factory reset** in Settings erases the wallet and every shard you hold
  for others. It is for handing the phone on, not for troubleshooting.
- **Change passphrase** is in Settings. Re-export afterwards.

## If you use the command-line wallet

Back up the **whole wallet directory** (`~/.railroad/wallet` by default), not
just the key file. The outbox and its position live beside the key, and a
backup of the key alone loses the chain. Full-disk encryption on the laptop
is your responsibility. After restoring from a backup, reach the station once
and run `rrn wallet sync` before you sign again.

The command-line wallet can *rebuild* from a circle (`rrn wallet recover`)
but cannot yet *set one up*; you split your key from the phone app. That
surface is deferred in
[ADR-0028](https://github.com/railroad-network/station/blob/main/docs/adr/0028-non-mobile-member-wallet.md).
