# Mobi Smart App

- install android tools

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
adb pull /data/app/~~vcwAY9qX6ICiTip_8pSWrg==/com.mobi.smart-fgNfcbFkT2caA3H0bNgNjw==/base.apk
adb pull /data/app/\~\~vcwAY9qX6ICiTip_8pSWrg==/com.mobi.smart-fgNfcbFkT2caA3H0bNgNjw==/split_config.arm64_v8a.apk
jadx base.apk
```



