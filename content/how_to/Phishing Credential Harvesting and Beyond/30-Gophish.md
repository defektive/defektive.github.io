+++
title = "Gophish"
weight = 30
+++

### Gophish

Now we can add gophish to our docker-compose. We are using a named volume here.

```yml

  gophish:
    image: gophish/gophish
    container_name: "gophish"
    ports:
      - "127.0.0.1:3333:3333"
      - "127.0.0.2:3333:3333"
      - "127.0.0.2:3333:3333"

    links:
      - "mailhog"

    volumes:
      - "gophish:/opt/gophish"

volumes:
  gophish: 
```

We need a password to login to gophish. Gophish automatically sets a password when you first start it.

```bash
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
