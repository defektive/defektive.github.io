+++
title = "Better Payload Generation"
weight = 100
+++

### Better implants (frostbyte bypass windows defender)

Instead of generating a executable. We can generate shellcode. We can then use something like [https://github.com/pwn1sher/frostbyte](https://github.com/pwn1sher/frostbyte) to load that shellcode into memory and execute it.

Lets get download the frostbyte zip from github.

```bash

```

We need a .net binary with a .config file. Windows has lots of those, so lets find one.


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