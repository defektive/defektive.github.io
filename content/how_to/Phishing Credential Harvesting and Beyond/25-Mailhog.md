+++
title = "Mailhog"
weight = 25
+++


We'll use Mailhog to test email sending and recieving. Lets add mail hog to our docker compose file

```yml
version: "3"
services:

  mailhog:
    image: mailhog/mailhog
    container_name: mailhog
    logging:
      driver: 'none'  # disable saving logs
    ports:
      - "127.0.0.1:8025:8025"

```