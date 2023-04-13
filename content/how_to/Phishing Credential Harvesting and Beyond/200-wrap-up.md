+++
title = "Wrap up"
weight = 200
+++

> THIS IS A ROUGH OUTLINE OF WHAT NEEDS TO BE FINISHED

### Terminate to implant download


### Better implants (frostbyte bypass windows defender)


### Bot Detection Dev / Testing


### Traefik Reverse Proxy


### What needs to change for live assessments

Now we have a decent understanding of our current capabilities. How can we successfully execute this for reals?

We need the following:

- A domain to send emails from.
- A domain to host malicous content. Could be the same, but it's nice have them separate in case one is burned.
- TLS Certs.
- A target and their permission.

### Domains

We like to use Amazon's Route53 for a number of reasons:

- It is pretty simple to acquire domains.
- Automatable with APIs.
- Tooling support.

### Gophish: Sending Emails FRD

Now we want to send real emails. We have quite a few options to do this. Our typical workflow is to use Amazon SES, but there are other options. Any service that supprts SMTP should work.

- SES
- Gmail
- Shared hosting (godaddy)
- Manually setting up postfix

It should be as simple as the Mailhog setup, but using the required credentials...

* * *

### Traefik TLS

Traefik can generate all the certs you need, it just needs an API key to manage DNS records on your domains.

* * *

### Where to from here?

- Automate VM Build.
- Automate infrastructure deployment.