+++
title = "Setup Operations Directory"
weight = 20
+++

We need a nice place to organize and store everything. For this exercise, we'll use `~/Desktop/op`. We'll also need a `docker` directory to put our docker configuration in.

```bash
mkdir -p ~/Desktop/op/docker
touch ~/Desktop/op/docker/docker-compose.yml
```

If `docker-dnsmasq` isn't running we should start it now.

```bash
sudo `which docker-dnsmasq` daemon
```