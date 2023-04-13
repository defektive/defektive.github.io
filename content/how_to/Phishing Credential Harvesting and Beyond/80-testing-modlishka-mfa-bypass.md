+++
title = "Test Modlishka MFA Bypass"
weight = 80
+++


Open up a new private browsing window, then visit [http://auth.target.docker:9000/?rid=test0001](http://auth.target.docker:9000/?rid=test0001). We'll make up a fake `rid` value to help us track our progress.

TODO: Screenshots

Lets go through the auth flow.

TODO: Screenshots

and now MFA

TODO: Screenshots

So we are stuck at a loading screen. this is because we hit the terminate trigger URL while loading a page. if we refresh the page we'll get redirected to our termination URL. Kind of jarring, but still acceptable.

Now that we've completed our login, lets check out the Modlishka data. Open [http://modlishka.docker/livewell/](http://modlishka.docker/livewell/), login with the credentials we configured (`phisherman:phisherpass`).

TODO: Screenshots

Lets click `View Cookies` on our testing UUID.

TODO: Screenshots

Now we can copy the value of the `authentik_session` cookie. Open [http://auth.target.docker:9000](http://auth.target.docker:9000) in a new private browsing window, and update the cookie value using dev tools.

TODO: Screenshots

Once completed, Lets reload our page...

TODO: Screenshots.

We are now logged in as the target.