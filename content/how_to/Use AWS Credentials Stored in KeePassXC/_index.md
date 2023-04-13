---
title: "Use AWS Credentials Stored in KeePassXC"
date: 2022-12-10T18:15:52-07:00
---

## Requirements

- KeePassXC
- aws-cli
- secret-tool

## Add a new group to KeePassXC

This will be used so we can control what secrets get exposed to the FreeDesktop.org Secret Service.

1. Right Click the Root folder group
1. Select New Group
1. Give it a Name
1. Click OK

## Enable Freedesktop.org Secret Service Integration

Open KeePassXC Settings.

1. Select Secret Service from the left hand side (it may be cut off).
1. Check the **Enable KeePassXC Freedesktop.org Secret Service Integration**.
1. Click the pencil next to your kbdx file.

## Expose group to secret service

1. Select Secret Service on the left hand side.
1. Select Expose entries under this group.
1. Select the group we created earlier.
1. Click OK

## Add Secrets to KeePassXC
Create some JSON with your AWS Credentials

```json
{
    "Version": 1,
    "AccessKeyId": "AKIA-REPLACE-ME",
    "SecretAccessKey": "REPLACE ME"
}
```

1. Select your group
1. Click the Create New Entry icon
1. Set the Title something meaningful
1. Paste your JSON in the password field
1. Click OK

## Configure AWS CLI to use custom program
Edit your ~/.aws.config

```
[profile default]
region = us-east-2
output=json
credential_process=secret-tool lookup Title "aws-creds"
```

## Test it out!

Running the AWS CLI should now trigger a KeePassXC prompt.

```bash
aws s3 ls
```
