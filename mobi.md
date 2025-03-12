# Mobi Smart App

- install android tools
- install objection
- install android sdk 
- install jadx
- install apktool

## List packages

```sh
adb shell pm list packages | grep smart


adb shell pm path com.mobi.smart
```

```
➜  ~ adb shell pm path com.mobi.smart
package:/data/app/~~vcwAY9qX6ICiTip_8pSWrg==/com.mobi.smart-fgNfcbFkT2caA3H0bNgNjw==/base.apk
package:/data/app/~~vcwAY9qX6ICiTip_8pSWrg==/com.mobi.smart-fgNfcbFkT2caA3H0bNgNjw==/split_config.arm64_v8a.apk
```

```sh
mkdir assets
cd assets
```

```sh
adb pull /data/app/~~vcwAY9qX6ICiTip_8pSWrg==/com.mobi.smart-fgNfcbFkT2caA3H0bNgNjw==/base.apk
adb pull /data/app/\~\~vcwAY9qX6ICiTip_8pSWrg==/com.mobi.smart-fgNfcbFkT2caA3H0bNgNjw==/split_config.arm64_v8a.apk
jadx base.apk
```


```sh
export _JAVA_OPTIONS=-Xmx4096m

objection patchapk -p -s base.apk
```


