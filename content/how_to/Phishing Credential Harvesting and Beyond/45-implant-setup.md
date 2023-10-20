+++
title = "Implant Setup With Sliver"
weight = 45
+++

### Basic Payload Delivery: Sliver

Sliver is an open source C2

- https://github.com/BishopFox/sliver/wiki/Getting-Started
- https://github.com/BishopFox/sliver/releases

Download the latest release and put in your `$PATH`. We should already have our dependencies installed when we setup the infrastructure.

```bash
mkdir ~/bin
wget -O ~/bin/sliver-server_linux https://github.com/BishopFox/sliver/releases/download/v1.5.41/sliver-server_linux
chmod +x ~/bin/sliver-server_linux
```