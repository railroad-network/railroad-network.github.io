# Back up and recover your keys

Your identity is a key on your phone. Your balance, your standing, your
history, and your vote all hang off it. There is no "forgot password" link,
because there is no company holding a copy. This page walks through, step by
step, what the app gives you instead: a passphrase, a **recovery circle** of
friends who each hold a sealed piece of your key, and an export you can carry
to another device.

> **Read the section [What can be rebuilt today](#what-can-be-rebuilt-today)
> before you rely on any of this.** Setting up a circle is fully built and
> worth doing now. The step that rebuilds a *phone's* key from the circle is
> not shipped yet. The export is the backup that works end to end today.

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
to contribute your piece. The ceremony is driven from a station console,
which shows a **request QR**.

1. Open Settings → Shards you hold → **Help someone recover**.
2. **Scan the request** the station is showing. The app checks that you
   actually hold a piece for the identity the request names; if not, it says
   so and stops.
3. **Confirm.** The app shows the address being recovered. **Check with the
   person in front of you that it is theirs.** The request itself carries no
   proof of who is asking, which is why this step happens face to face and
   not over a photo someone sent you.
4. **Enter your passphrase.** Your phone opens your sealed piece and re-seals
   it to this one ceremony.
5. **Show this to your friend.** The app displays a **response QR**. The
   person running the ceremony scans it. The response is useless to anyone
   else and for any other ceremony, so if you truly cannot attend, it is
   acceptable to relay the response over a chat, provided you trust that the
   request reached you intact.

## What can be rebuilt today

Here is the honest state of the rebuild step, which is the whole point of a
backup.

**The station's key: yes, fully.** The operator arms the station's own
recovery with a circle of members exactly as above, and the ceremony in
[Backups and key recovery](../operators/backups-and-key-recovery.md) collects
holders' responses at the station console and rebuilds the key, even when the
passphrase is gone. This is built, tested, and drilled.

**A member's phone key: not yet.** The app can split your key, holders can
hold pieces, and holders can answer a request. What does not exist is the
screen that *makes* the request for a member and gathers the responses on a
new phone. There is no "recover" option when you install the app, and the
station's ceremony can only target the station's own key. The project's own
records say this plainly and it is on the list. Until it lands:

- **Set up your circle anyway.** The shards you hand out now are the ones
  the rebuild flow will use. Doing it later means doing it after you have
  lost the phone, which is too late.
- **Also do the export below.** It is the backup that works end to end
  today.

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

Today the restore target is the **command-line wallet** on a computer. The
app has no import screen yet.

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
station like a forked identity, which costs your whole standing.

> **Rehearse this once**, on a laptop, while your phone still works. A backup
> you have never restored is a hope, not a plan.

## If your phone is lost or stolen

1. **Tell the operator.** They **unpair** the old phone so it can no longer
   sync. The key on it is still encrypted under your passphrase; a thief
   needs that to use it.
2. **If you have an export**, restore it into the command-line wallet as
   above, sync, and carry on. You can pair a new phone later as a fresh
   identity if you prefer, but that identity starts from zero.
3. **If you only have a circle**, your shards are safe with your holders and
   the rebuild flow is what will use them. Do not re-create a wallet on a new
   phone under the assumption you can merge later; you cannot.

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

The command-line wallet has no recovery circle of its own yet; that surface
is deferred in
[ADR-0028](https://github.com/railroad-network/station/blob/main/docs/adr/0028-non-mobile-member-wallet.md).
