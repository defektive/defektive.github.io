+++
title = "Mailhog"
weight = 25
+++

MailHog is an SMTP server used for testing various applications that send emails. It provides a simple web interface to view what messages have been sent. Let's edit our new `~/Desktop/op/docker/docker-compose.yml` file and add the following to configure MailHog.

```yml
version: "3"
services:

  mailhog:
    image: mailhog/mailhog
    container_name: mailhog
    environment:
      - VIRTUAL_HOST=mailhog.docker
    logging:
      driver: 'none'  # disable saving logs

```

Now we should be able to bring up our docker compose environment to test that it is working.

```bash
cd ~/Desktop/op/docker/
sudo docker compose up
```

Let's open up the web interface now [http://mailhog.docker:8025/](http://mailhog.docker:8025/).

![MailHog Landing Page](/static/how-to-phishing/mailhog-first-setup.png)
