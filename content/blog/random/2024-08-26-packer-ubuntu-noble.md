---
title: Packer, Ubuntu Noble, and VirtualBox
date: 2024-08-26
draft: true
description: >
  Adventures with automating VM builds
---

I have been using Packer for quite a while. However, all my interactions have used JSON instead of HCL. I wanted to setup a new build using HCL, VirtualBox, and Ubuntu 24.04. I am going to attempt to create some documents for using HCL with VirtualBox to build a custom image based on the latest Ubuntu LTS release (with cloud init).

I did find some decent things for QEMU and VMWare

- QEMU: https://github.com/shantanoo-desai/packer-ubuntu-server-uefi/tree/main
- VMWare: https://github.com/ynlamy/packer-ubuntuserver24_04/blob/main/vmware-iso-ubuntuserver24_04.pkr.hcl

So we'll use this as a reference while we build.

Lets start by checking out the documentation at https://developer.hashicorp.com/packer/integrations/hashicorp/virtualbox.

```hcl

```

Since we are using cloud init, we'll need to create some files for packer to host via HTTP. When our VM boots up, it will consume these files and setup our VM.

```hql

```

I battled this for a bit and realized I need to create an empty `meta-data` file. If that file isn't there, Ubuntu will not attempt to read the other file.
