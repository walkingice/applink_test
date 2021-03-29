y Introduction

This is a very simple app with just three activities, for testing app links.

There is already a prepared json file on my own [host applinks.cmds.dev](https://applinks.cmds.dev/.well-known/assetlinks.json).

# Installation

* Build this app by Android Studio

a successful installation of this app will give log

```
I/IntentFilterIntentOp: Verifying IntentFilter. verificationId:4 scheme:"https" hosts:"applinks.cmds.dev" package:"net.julianchu.applinktest".
I/IntentFilterIntentOp: Verification 4 complete. Success:true. Failed hosts:.
```

Use this command to check verification

```bash
$ adb shell dumpsys package d
```

Use this command to test app-link. FirstActivity will be launched.

```bash
$ adb shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE  -d "https://applinks.cmds.dev/foobar"
```

# Problem

The problem is **Intent-filter-verifier won't execute anymore, if it has been passed once.**

* If your configuration of AndroidManifest.xml is incorrect, every re-installation will cause Intent-Fitler-Verifier execution, this is good.
* If you pass verification for just **ONCE**. The verification won't be executed anymore, until you manually uninstall app. (which cause removing-data-of-app of course).
* So far I have not idea whether is problem is due to `adb install` or not. Maybe it works well if upgrading an app via Google-play-store.
    * If so, this means we cannot do any reliable test in developemnt. :-/

# Advance test

Since the verification won't be executed again, now we can corrupt the intent-filter

1. change attribute `android:host` to any one you don't own, even `line.me` still works.
1. Add new intent filter to another activity to handle app link, it also works.

How to reproduce

1. build **master** branch and install app via adb, now it should pass intent-filter-verifier.
1. check to **hijack_app_link** branch, build and install again.

    this branch added one more intent-filter to SecondActivity to handle 'google.com'. Of course I don't have access to the domain.

1. open a link by sending intent, now SecondActivity will be launched.

    ```
    $ adb shell dumpsys package d  # the order of filters does matter. If this app is prior than other handler...then
    $ adb shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE  -d "https://google.com"
    ```

You will see SecondActivity handled the intent.

# Reference

* [Google doc: Verify Android App Links](https://developer.android.com/training/app-links/verify-site-associations)
* [Android M "App Links" implementation in depth](https://chris.orr.me.uk/android-app-linking-how-it-works/)
