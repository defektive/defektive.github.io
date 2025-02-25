---
title: "Use AWS Credentials Stored in KeePassXC"
date: 2022-12-10T18:15:52-07:00
description:
  How to setup and use AWS credentials stored in KeePassXC
---

## Requirements

- KeePassXC
- aws-cli
- secret-tool

## Add a new group to KeePassXC

This will be used so we can control what secrets get exposed to the FreeDesktop.org Secret Service.

1. Right-Click the Root folder group
2. Select New Group
3. Give it a Name
4. Click OK

## Enable Freedesktop.org Secret Service Integration

Open KeePassXC Settings.

1. Select Secret Service from the left hand side (it may be cut off).
2. Check the **Enable KeePassXC Freedesktop.org Secret Service Integration**.
3. Click the pencil next to your kbdx file.

## Expose group to secret service

1. Select Secret Service on the left hand side.
2. Select Expose entries under this group.
3. Select the group we created earlier.
4. Click OK

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
2. Click the Create New Entry icon
3. Set the Title something meaningful
4. Paste your JSON in the password field
5. Click OK

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
