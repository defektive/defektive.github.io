+++
title = "Modlishka requirements"
weight = 63
+++

Modlishka requires DNS resolution, so we are going to replace the default `systemd-resolved` in ubuntu and replace it with `dnsmasq`. Then we'll use a program to populate `dnsmasq` config with docker container information. This step is only for local testing.

This [article](https://computingforgeeks.com/install-and-configure-dnsmasq-on-ubuntu/) came in handy to switch to `dnsmasq`.

Now we need to instal golang and `docker-dnsmaq`.

```bash
sudo apt install golang
go install github.com/defektive/docker-dnsmasq@latest
```

No we should be able to run this in a new terminal window:

```bash
sudo ~/go/bin/docker-dnsmasq daemon
```

we can test everything is working properly by pinging a docker container using it's `VIRTUAL_HOST` name.

```bash
ping mailhog.docker
```

![Ping Docker Container](/static/how-to-phishing/ping-docker-container.png)

We should also be able to ping random subdomains:

```bash
ping asdasd.gophish.docker
```

![Ping Docker Container Subdomain](/static/how-to-phishing/ping-docker-container-subdomain.png)
