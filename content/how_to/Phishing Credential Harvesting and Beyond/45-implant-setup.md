+++
title = "Implant Setup With Sliver"
weight = 45
+++

### Basic Payload Delivery: Sliver

Sliver is an open source C2
- https://github.com/BishopFox/sliver/wiki/Getting-Started
- https://github.com/BishopFox/sliver/releases

```bash
sudo apt install mingw-w64
mkdir -p ~/opt/sliver
wget -O ~/opt/sliver/sliver-server_linux https://github.com/BishopFox/sliver/releases/download/v1.5.36/sliver-server_linux
chmod +x ~/opt/sliver/sliver-server_linux
```

### Testing windows implants

To test windows implants on Linux, install wine (https://wiki.winehq.org/Ubuntu):

```bash
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings\nsudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
sudo apt update
sudo apt install --install-recommends winehq-stable
```

Now a quick test in a terminal:

```bash
wine cmd.exe
```

You may get some prompts to follow, you should follow them... Eventually you should get a nice `cmd.exe` prompt.

![Wine CMD](/static/how-to-phishing/wine-cmd.png)
