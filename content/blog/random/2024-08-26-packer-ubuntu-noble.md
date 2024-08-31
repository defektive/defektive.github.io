---
title: Packer, Ubuntu Noble, and VirtualBox
date: 2024-08-31
description: >
  Adventures with automating VM builds
---

I have been using Packer for quite a while. However, all my interactions have
used JSON instead of HCL. I wanted to set up a new build using HCL, VirtualBox,
and Ubuntu 24.04. I am going to attempt to create documentation for using HCL
with VirtualBox to build a custom image based on the latest Ubuntu LTS release
(with cloud init).

In my research I found some decent guides that did most of what I wanted. I'll
use these a reference for building my specific use case.

- QEMU: https://github.com/shantanoo-desai/packer-ubuntu-server-uefi/tree/main
- VMWare: https://github.com/ynlamy/packer-ubuntuserver24_04/blob/main/vmware-iso-ubuntuserver24_04.pkr.hcl

The official docs will also come in handy and can be found here: https://developer.hashicorp.com/packer/integrations/hashicorp/virtualbox.

```hcl
# virtualbox.pkr.hcl
packer {
  required_version = ">= 1.7.0"
  required_plugins {

    virtualbox = {
        version = "~> 1"
        source  = "github.com/hashicorp/virtualbox"
    }
    ansible = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "virtualbox-iso" "packer-vm-ubuntu" {
  guest_os_type = "Ubuntu_64"
  iso_url = "https://releases.ubuntu.com/noble/ubuntu-24.04-live-server-amd64.iso"
  iso_checksum = "sha256:8762f7e74e4d64d72fceb5f70682e6b069932deedb4949c6975d0f0fe0a91be3"
  http_directory = "./http/24.04/"
  ssh_username = "packer"
  ssh_password = "packer"
  ssh_timeout = "10m"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  headless = false
  firmware = "efi"
  boot_command = ["e<wait><down><down><down><end> autoinstall 'ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'<F10>"]
  boot_wait    = "5s"
  vboxmanage = [
        [
          "modifyvm",
          "{{.Name}}",
          "--memory",
          "4096"
        ],
        [
          "modifyvm",
          "{{.Name}}",
          "--cpus",
          "4"
        ],
        [
          "modifyvm",
          "{{.Name}}",
          "--nat-localhostreachable1",
          "on"
        ]
      ]

}

# build {
#   sources = ["sources.virtualbox-iso.packer-vm-ubuntu"]
#   
#   provisioner "ansible" {
#     playbook_file = "../../ansible/ubuntu-desktop.yaml"
#   }
# }
```

I'd like to point out a few things. First the `http_directory` property
specifies a directory to be exposed via HTTP. This will be consumed by
`cloud-init`. We'll use that to create our initial user.

In the out `http_directory` we'll need to create two files.

- meta-data
- user-data

We'll leave `meta-data` empty, if it is not there, `cloud-init` will refuse to
consume our `user-data` file.

```yaml
#cloud-config
autoinstall:
  version: 1
  locale: en_US
  keyboard:
    layout: us
  ssh:
    install-server: true
    allow-pw: true
  packages:
    - zsh
  updates: all
  late-commands:
    - |
      if [ -d /sys/firmware/efi ]; then
        apt-get install -y efibootmgr
        efibootmgr -o $(efibootmgr | perl -n -e '/Boot(.+)\* Ubuntu/ && print $1')
      fi
  user-data:
    preserve_hostname: false
    hostname: carbon
    package_upgrade: true
    timezone: UTC
    users:
      - name: packer
        # passwd must be a password hash, you can generate it with `openssl passwd -6 replacewithyourpassword`
        passwd: $6$ZfIbBMQd5rmGTGPk$AWrvIL1v4Xq6jsSR72KsSONa2VpSnr8SZHPDF2l6pNNcQ3HKjqWF2JEBYepl4LnnmzKiKFEcRuf7lfyOMooq50
        groups: [adm, cdrom, dip, plugdev, lxd, sudo]
        lock-passwd: false
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/zsh
```

Now we should be able to build our VM using VirtualBox.

```bash
packer build virtualbox.pkr.hcl
```

If you have an ansible playbook, you can reference it in the build section.
