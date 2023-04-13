+++
title = "Gophish"
weight = 30
+++

### Gophish

Let's create a file for our Gophish config:

```bash
mkdir -p ~/Desktop/op/docker/gophish
touch ~/Desktop/op/docker/gophish/config.json
```

```json
{
	"admin_server": {
		"listen_url": "0.0.0.0:3333",
		"use_tls": false,
		"cert_path": "gophish_admin.crt",
		"key_path": "gophish_admin.key",
		"trusted_origins": []
	},
	"phish_server": {
		"listen_url": "0.0.0.0:80",
		"use_tls": false,
		"cert_path": "example.crt",
		"key_path": "example.key"
	},
	"db_name": "sqlite3",
	"db_path": "gophish.db",
	"migrations_prefix": "db/db_",
	"contact_address": "",
	"logging": {
		"filename": "",
		"level": ""
	}
}
```

Now we can add gophish to our docker-compose services. 

```yml
  gophish:
    image: gophish/gophish
    container_name: "gophish"
    environment:
      - VIRTUAL_HOST=gophish.docker
    ports:
      - "127.0.0.1:3333:3333"
      - "127.0.0.2:80:80"
      - "127.0.0.2:443:443"

    links:
      - "mailhog"

    volumes:
      - "gophish:/opt/gophish"
      - "./gophish/config.json:/opt/gophish/config.json"
```

Finally we ne need to add a gophish named volume to the end:
```yml
volumes:
  gophish: 
```

We should be able to brind up docker compose now:

```bash
cd ~/Desktop/op/docker
sudo docker compose up
```

We need a password to login to gophish. Gophish automatically sets a password when you first start it. So lets open a new terminal and run the following.

```bash
cd ~/Desktop/op/docker
sudo docker compose logs gophish | grep " password "
```

- Open https://localhost:3333/
- login with admin and the password you found in the logs
- change password

* * *

### Gophish SMTP Mailhog

Go to `Sending Profiles` > `+ New Sending Profile`.

![SMTP Settings](/static/how-to-phishing/gophish-mailhog-smtp.png)

- `Send Test Email`
- We should see a nice tesing email in mailhog
- Click `Save`
