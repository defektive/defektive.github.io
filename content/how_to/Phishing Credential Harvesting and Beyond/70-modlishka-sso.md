+++
title = "Setup MFA Authentication Provider"
weight = 70
+++

> If attending a live training, skip this section

Now that we have Modlishka up and running. Let's get it configured with a target login provider. We'll use Authentik to get an Okta like experience.

```bash
sudo apt-get install -y pwgen
mkdir ~/Desktop/op/docker/authentik
cd ~/Desktop/op/docker/
echo "PG_PASS=$(pwgen -s 40 1)" >> .env
echo "AUTHENTIK_SECRET_KEY=$(pwgen -s 50 1)" >> .env
echo "AUTHENTIK_ERROR_REPORTING__ENABLED=true" >> .env
```

Add the follow for emails...

```sh
# SMTP Host Emails are sent to
AUTHENTIK_EMAIL__HOST=mailhog
AUTHENTIK_EMAIL__PORT=1025
# Optionally authenticate (don't add quotation marks to your password)
AUTHENTIK_EMAIL__USERNAME=
AUTHENTIK_EMAIL__PASSWORD=
# Use StartTLS
AUTHENTIK_EMAIL__USE_TLS=false
# Use SSL
AUTHENTIK_EMAIL__USE_SSL=false
AUTHENTIK_EMAIL__TIMEOUT=10
# Email address authentik will send from, should have a correct @domain
AUTHENTIK_EMAIL__FROM=authentik@target.docker
```

Now we'll merge their `docker-compose.yml` with ours ([ref](https://goauthentik.io/docs/installation/docker-compose)). We'll start with the services. 

```yml

  authentik-postgresql:
    image: docker.io/library/postgres:12-alpine
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -d $${POSTGRES_DB} -U $${POSTGRES_USER}"]
      start_period: 20s
      interval: 30s
      retries: 5
      timeout: 5s
    volumes:
      - database:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=${PG_PASS:?database password required}
      - POSTGRES_USER=${PG_USER:-authentik}
      - POSTGRES_DB=${PG_DB:-authentik}
    env_file:
      - .env
  authentik-redis:
    image: docker.io/library/redis:alpine
    command: --save 60 1 --loglevel warning
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "redis-cli ping | grep PONG"]
      start_period: 20s
      interval: 30s
      retries: 5
      timeout: 3s
    volumes:
      - redis:/data
  authentik-server:
    image: ${AUTHENTIK_IMAGE:-ghcr.io/goauthentik/server}:${AUTHENTIK_TAG:-2023.3.1}
    restart: unless-stopped
    command: server
    environment:
      VIRTUAL_HOST: target.docker
      AUTHENTIK_REDIS__HOST: authentik-redis
      AUTHENTIK_POSTGRESQL__HOST:  authentik-postgresql
      AUTHENTIK_POSTGRESQL__USER: ${PG_USER:-authentik}
      AUTHENTIK_POSTGRESQL__NAME: ${PG_DB:-authentik}
      AUTHENTIK_POSTGRESQL__PASSWORD: ${PG_PASS}
    volumes:
      - ./authentik/media:/media
      - ./authentik/custom-templates:/templates
    env_file:
      - .env
    ports:
      - "${AUTHENTIK_PORT_HTTP:-9000}:9000"
      - "${AUTHENTIK_PORT_HTTPS:-9443}:9443"
  authentik-worker:
    image: ${AUTHENTIK_IMAGE:-ghcr.io/goauthentik/server}:${AUTHENTIK_TAG:-2023.3.1}
    restart: unless-stopped
    command: worker
    environment:
      AUTHENTIK_REDIS__HOST: authentik-redis
      AUTHENTIK_POSTGRESQL__HOST: authentik-postgresql
      AUTHENTIK_POSTGRESQL__USER: ${PG_USER:-authentik}
      AUTHENTIK_POSTGRESQL__NAME: ${PG_DB:-authentik}
      AUTHENTIK_POSTGRESQL__PASSWORD: ${PG_PASS}
    # `user: root` and the docker socket volume are optional.
    # See more for the docker socket integration here:
    # https://goauthentik.io/docs/outposts/integrations/docker
    # Removing `user: root` also prevents the worker from fixing the permissions
    # on the mounted folders, so when removing this make sure the folders have the correct UID/GID
    # (1000:1000 by default)
    user: root
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./authentik/media:/media
      - ./authentik/certs:/certs
      - ./authentik/custom-templates:/templates
    env_file:
      - .env
```

We also need to update our volumes:

```yml

volumes:
  database:
    driver: local
  redis:
    driver: local
```

Lets test it out.

```bash
sudo docker compose up
```

Now open [http://auth.target.docker:9000/if/flow/initial-setup/](http://auth.target.docker:9000/if/flow/initial-setup/). We should see a simple setup page.

![Authentik Admin Setup](/static/how-to-phishing/authentik-admin-setup.png)

## Setup MFA

![Authentik Admin Add MFA](/static/how-to-phishing/authentik-admin-add-mfa.png)


