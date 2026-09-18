# Keep your keys safe

Your identity is a key on your phone. If you lose the key, you lose the
identity, along with its balance, standing, and history. There is no
"forgot password" link, because there is no company holding a copy. So the
software gives you a way to hold a copy among your friends instead.

## The passphrase

You chose a passphrase when you created your wallet. It encrypts the key on
the phone. Fingerprint or face unlock is a convenience on top of it, not a
replacement: you will still need the passphrase after a restart and in
recovery ceremonies.

Write it down and keep it somewhere safe, on paper. A passphrase that exists
only in one head is one bad week from being gone.

## Social recovery

**Social recovery** splits your key into pieces, called **shards**, and hands
one to each of several people you trust. No single shard reveals anything. A
threshold of them, say 3 of 5, brought together can rebuild the key.

Set it up early, from the Home screen ("Protect your account"):

1. Choose your holders: members you trust and who are unlikely to all vanish
   at once. Three of five is a good shape.
2. The app seals a shard to each holder's phone. Hand them over in person; the
   holder scans and the shard sits on their phone doing nothing, possibly for
   years.
3. If you replace a holder later, re-run setup. Old shards stop working.

To recover on a new phone: install the app, choose **Recover**, and gather a
threshold of your holders. Each opens **Shards you hold → Help someone
recover**, scans your request, checks it is really you, and their phone gives
back a response. Enough responses and your identity is back, with a new
passphrase.

## Shards you hold for others

You may also be asked to hold shards for other members, and for the community
station itself. The operator arms the station's own recovery the same way,
with a few trusted members as holders. Holding a shard costs you nothing and
asks nothing until the day someone needs it. Then it asks you to show up.

## If your phone is lost or stolen

1. Tell the operator. They will **unpair** the old phone so it can no longer
   sync with the station. The key on the old phone is still encrypted under
   your passphrase, so a thief cannot use it without that.
2. Recover onto a new phone with your holders, as above.
3. Pair the new phone with the station: the same in-person ceremony as when
   you [first joined](join-your-community.md).

## Updates

Install a newer app over the old one. Never uninstall first: that erases the
wallet on the phone and turns a routine update into a recovery ceremony.

## If you use the command-line wallet

Back up the **whole wallet directory** (`~/.railroad/wallet` by default), not
just the key file. The outbox and its position live next to the key, and a
backup of the key alone loses the chain. Full-disk encryption on the laptop is
your responsibility. After restoring from a backup you must reach the station
once and sync before you can sign again.
