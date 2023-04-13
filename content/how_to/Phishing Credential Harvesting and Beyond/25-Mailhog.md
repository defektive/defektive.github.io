+++
title = "Mailhog"
weight = 25
+++

Mailhog is an SMTP server used for testing various applications that send emails. It provides a simple web interface to view what messages have been sent. Let's edit our new `~/Desktop/op/docker/docker-compose.yml` file and add the folloinw to configure Mailhog.

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
    ports:
      - "127.0.0.1:8025:8025"

```

Now we should be able to bring up our docker compose environment to test that it is working.

```bash
cd ~/Desktop/op/docker/
sudo docker-compose up
```

Let's open up the web interface now [http://localhost:8025](http://localhost:8025).
