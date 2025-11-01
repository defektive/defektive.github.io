---
title: Publish Flutter App to Google Play Using GitHub Actions 
date: 2025-10-31
description: >
  Embracing continuous delivery
---

I have been wanting to do more mobile app development and streamline the release process for a while now. I read a few things on how to publish to the Play Store with GitHub actions, but I kept running into issues. I'll try to document what the issues were and how I was able to get past them.

I am using https://github.com/r0adkll/upload-google-play to publish actions. To make testing easier, I used https://github.com/nektos/act to run my GitHub actions locally. I used the largest docker image, since the other ones didn't seem to have what I needed for Android builds.


### First Issue `Error: Unknown error occurred.`

The first issue I ran into was: `Error: Unknown error occurred.`. There a few issues filed about this error. The consensus is to check that your are referencing your secrets with the appropriate variable names and config options.

I checked out the https://github.com/r0adkll/upload-google-play repo and manually invoked `lib/index.js` to quickly test my configs worked.

```bash
git clone https://github.com/r0adkll/upload-google-play.git  
```

I had to dig into how actions are executed and how the arguments are passed to the action. It turns out, they all become environment variables prefixed with `INPUT_`. My invocation looked something like this:

```bash
INPUT_PACKAGENAME=example.package.name \
INPUT_TRACK=production \
INPUT_SERVICEACCOUNTJSONPLAINTEXT=$(cat ~/Downloads/google-cloud-credentials.json | jq -c) \
INPUT_STATUS=completed \
INPUT_RELEASEFILES=$HOME/flutter-project-dir/build/app/outputs/flutter-apk/app-release.apk \
INPUT_DEBUG=1 \
node lib/index.js 
```

This helped me confirm/determine my secrets were being referenced incorrectly.


### Second Issue `You cannot rollout this release because it does not allow any existing users to upgrade to the newly added APKs.`

This one didn't make sense, so I switched to doing a draft release. So I could inspect the release from the Play Console. Turns out that my efforts to support WearOS made it so I could not support Android phones. This meant none of the android phones using my app would not be able to upgrade to the new version. So I ended up reverting my app support for WearOS. I'll have to figure out how to support watches and phones later. 