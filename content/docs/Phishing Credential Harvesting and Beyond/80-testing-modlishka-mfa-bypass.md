+++
title = "Test Modlishka MFA Bypass"
weight = 80
+++


Open up a new private browsing window, then visit [http://modlishka.docker/?rid=test0001](http://modlishka.docker/?rid=test0001). We'll make up a fake `rid` value to help us track our progress.

![Modlishka MFA Login](/static/how-to-phishing/modlishka-mfa-landing.png)

Lets go through the authentication flow. You can Modlishka seamlessly handles the redirects and the MFA authentication flow.

![Modlishka MFA Prompt](/static/how-to-phishing/modlishka-auth-mfa-prompt.png)

So we are stuck at a loading screen. this is because we hit the terminate trigger URL while loading a page. 

![Modlishka Authentication Loading](/static/how-to-phishing/modlishka-auth-success-loader.png)

If we refresh the page we'll get redirected to our termination URL. Kind of jarring, but still acceptable.

Now that we've completed our login, lets check out the Modlishka data. Open [http://modlishka.docker/livewell/](http://modlishka.docker/livewell/), login with the credentials we configured (`phisherman:phisherpass`).

![Modlishka Livewell](/static/how-to-phishing/modlishka-livewell.png)

Lets click `View Cookies` on our testing UUID.

![Modlishka Livewell Authentication Cookie](/static/how-to-phishing/modlishka-livewell-auth-cookie.png)

Now we can copy the value of the `authentik_session` cookie. Open [http://auth.target.docker:9000](http://auth.target.docker:9000) in a new private browsing window, and update the cookie value using developer tools.

![Replace Session Cookie to Current Session](/static/how-to-phishing/reuse-session-cookie.png)

Once completed, visit the root URL again [http://auth.target.docker:9000/](http://auth.target.docker:9000/)

![Phished Admin Session](/static/how-to-phishing/phished-admin-session.png)

We are now logged in as the target.