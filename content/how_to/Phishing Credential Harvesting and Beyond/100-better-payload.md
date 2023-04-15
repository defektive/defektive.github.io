+++
title = "Better Payload Generation"
weight = 100
+++

### Better implants (frostbyte bypass windows defender)

Instead of generating a executable. We can generate shellcode. We can then use something like [https://github.com/pwn1sher/frostbyte](https://github.com/pwn1sher/frostbyte) to load that shellcode into memory and execute it.

Lets get download the [frostbyte zip](https://github.com/pwn1sher/frostbyte/archive/refs/heads/main.zip) from Github.

```bash

```

We need a .net binary with a .exe.config file. Windows has lots of those in `C:\Windows\Microsoft.NET\Framework64\v4.0.30319`.

![Windows Executable with Config](/static/how-to-phishing/windows-executable-with-config.png)


```bash

```

Lets conver our shell code.

```bash

```

Update the code in ....

```csharp

```

build ....



test ....