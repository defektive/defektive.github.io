+++
title = "Infrastructure"
weight = 20
+++

### Op VM

We need a place to deploy all our stuff. For this workshop, we'll be using VirtualBox and the latest [Ubuntu LTS](https://ubuntu.com/download/desktop/thank-you?version=22.04.2&architecture=amd64) (22.04 LTS). [Ubuntu has a great walkthrough on how to do this](https://ubuntu.com/tutorials/how-to-run-ubuntu-desktop-on-a-virtual-machine-using-virtualbox#1-overview).

### Windows VM

We'll want a Windows box to do a little bit of payload development and testing. I recommend downloading the latest ISO from https://www.microsoft.com/en-us/software-download/windows10ISO.


### Ubuntu: Install Tooling

We need a handful of tools to accomplish our goals

- git
- docker (pdman-docker)

following: https://docs.docker.com/engine/install/ubuntu/

```bash

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    git vim
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
```

I also installed VS Code (https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64)


### Clone Repo for future reference

```bash
mkdir ~/opt/
cd ~/opt/
git clone replaceme
cd repolaceme/docker/
``` 

### Ensuring it all works

```bash
sudo docker compose up
```

open https://localhost:3333/
