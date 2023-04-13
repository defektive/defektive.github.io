+++
title = "Infrastructure"
weight = 20
+++


We'll be using a few different VMs through out this process. Let's kick off the downloads now since they make take some time to complete.

- [Ubuntu LTS](https://ubuntu.com/download/desktop/thank-you?version=22.04.2&architecture=amd64)
- [Windows 10](https://www.microsoft.com/en-us/software-download/windows10ISO)

### Op VM

We need a place to deploy all our stuff. For this workshop, we'll be using VirtualBox and the latest Ubuntu LTS (22.04 LTS). [Ubuntu has a great walk through on how to do this](https://ubuntu.com/tutorials/how-to-run-ubuntu-desktop-on-a-virtual-machine-using-virtualbox#1-overview).

#### Install Tooling

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

In an effort to make things more clear and easier to understand while we hop through browser tabs and URLS, we'll want to setup some DNS magic for our docker containers. This requires us to replace the default `systemd-resolved` in Ubuntu with `dnsmasq`. Then we'll use a program to populate `dnsmasq` configuration with docker container information. This step is only for local testing.

This [article](https://computingforgeeks.com/install-and-configure-dnsmasq-on-ubuntu/) came in handy to switch to `dnsmasq`. In addition to that article, we'll also need to add the following to the `dnsmasq.conf`


```conf
conf-dir=/etc/dnsmasq.d
```

Now we need to install Golang so we can build [docker-dnsmaq](https://github.com/defektive/docker-dnsmasq).

```bash
sudo apt install golang
go install github.com/defektive/docker-dnsmasq@latest
```

Now we should be able to run this in a new terminal window:

```bash
sudo ~/go/bin/docker-dnsmasq daemon
```

We can test everything is working properly by starting a container with the `VIRTUAL_HOST` environment variable. Then pinging that docker container `VIRTUAL_HOST` name.

```bash
ping mailhog.docker
```

![Ping Docker Container](/static/how-to-phishing/ping-docker-container.png)

We should also be able to ping random subdomains:

```bash
ping asdasd.mailhog.docker
```

![Ping Docker Container Subdomain](/static/how-to-phishing/ping-docker-container-subdomain.png)

### Windows VM

We'll want a Windows box to do a little bit of payload development and testing. Once windows is installed, we'll need to install [Visual Studio Community](https://visualstudio.microsoft.com/vs/community/). When configuring visual studio select *.NET Development*.

TODO: Screenshots