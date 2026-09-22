# Install the app

There is no app store listing. Your organizer or operator hands you a signed
installer file for Android, and you install it directly. iPhones are not
supported for pilots today.

## What you need

- An Android phone from roughly 2017 or later (64-bit).
- The file `app-release.apk`, from whoever runs your community.
- To be on the same Wi-Fi as the community's station when you join. After
  that, you only need to reach it now and then to sync.

## Install

1. **Get the file onto your phone.** Email, a USB cable, or a download link
   all work.
2. **Allow the install.** Open the file. Android will ask whether to allow
   "install unknown apps" for whichever app you opened it from (Files, Chrome,
   and so on). Allow it, then tap **Install**.
3. **Open the app.** It walks you through creating your wallet: choose a
   passphrase, optionally turn on fingerprint or face unlock, and the app
   generates your address, a long string that starts with `rrn1`.

Your key is created on the phone and never leaves it. Nobody, including the
station, can act as you.

## Updating

When you are handed a newer `app-release.apk`, install it over the top. Your
wallet and history are preserved.

> **Do not uninstall first.** Uninstalling erases the wallet on the phone. You
> can get your identity back from a [wallet export or your recovery circle](keep-your-keys-safe.md),
> but only if you set one of those up beforehand.

## If the app stops syncing in the background

Some phones, Motorola in particular, cut off a backgrounded app's network
access until you exempt it from battery optimization. If notifications or
background sync stop working:

Settings → Apps → **Railroad Network** → Battery → allow **Unrestricted**.

The wording varies by phone. Your operator has a per-vendor checklist if that
does not fix it.

## Using a computer instead

A member with a laptop and no Android phone can hold their own key with the
command-line wallet instead. It is the same identity model, driven from a
terminal, and unlike the app today it can sign while the station is out of
reach. See [Using a computer instead of a phone](using-a-computer.md).
