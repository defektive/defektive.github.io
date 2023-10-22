+++
title = "Traefik Reverse Proxy"
weight = 125
+++


### Traefik Reverse Proxy

Now that we have a reliable way to detect bots, we need to be able to make that determination before showing the phishing page. Then we can show bots simple non-malicious content and users will get our phishing pages. We can do this using traefik to route requests based on cookies. We can put traefik in front of Modlishka and force all request to go through a simple bot check before loading our phishing site.

We'll start by adding a new Traefik container.

```yml


```


Then we'll add a new NGINX container to serve our bot detection landing page.

```yml

```

Now we can create our bot detection landing page

```bash

```

paste the content:
```html


```

Add some additional configuration to the modlishka container so Traefik can act as a proxy for it.


Now we can test it out.

```bash
sudo docker compose up
```

Now we can use our new traefik URL as our Gophish URL in a phishing campaign.

