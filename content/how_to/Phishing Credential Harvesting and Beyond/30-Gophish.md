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
sudo docker compose up
```

We need a password to login to gophish. Gophish automatically sets a password when you first start it. So lets open a new terminal and run the following.

```bash
cd ~/Desktop/op/docker
sudo docker compose logs gophish | grep " password "
```

![Gophish Initial Password](/static/how-to-phishing//gophish-initial-password.png)

- Open [http://gophish.docker:3333/](http://gophish.docker:3333/).
- login with the user `admin` and the password you found in the logs.
- change password (I used `gophishpass` for the VM).

* * *

### Gophish SMTP Mailhog

Go to `Sending Profiles` > `+ New Sending Profile`.

- Set **Name** to `Mailhog SMTP Testing Server`.
- Set **SMTP From** to an email, I used `admin@phishing.test`.
- Set **Host** to `mailhog:1025`, as this is the name of the linked container in the docker compose file.
- Add a new Email Header `X-Mailer` and set it to `Outlook`. This overrides Gophish's default of `Gophish`.

![SMTP Settings](/static/how-to-phishing/gophish-mailhog-smtp.png)

- Click `Send Test Email`.
- Fill out the fields with mostly random things.

![Gophish Mailhog Send Test Email](/static/how-to-phishing/gophish-mailhog-smtp-test-email.png)

- We should see a nice tesing email in mailhog

![Mailhog Gophish Test Email](mailhog-gophish-test-email.png)

- Since everything is working, Click `Save` on the send profile.
