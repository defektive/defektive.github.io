+++
title = "Wrap up"
weight = 200
+++

> THIS IS A ROUGH OUTLINE OF WHAT NEEDS TO BE FINISHED

### Bypassing Email Filtering

A lot of times emails will be quarentined based on content. We can trick them by injecting invisble characters and html elements into our messages. 

We can use a Zero Width Joiner [ref](https://emojipedia.org/zero-width-joiner/) to assist in this. simply pasting the character in the middle of problematic words should do the trick.

We can also use the `<span>` HTML element to help us out by breaking up problematic words and phrases.

Text:

```txt
All,

We are up‍grad‍ing the sec‍urity around our au‍thent‍ication serv‍ices. Please lo‍g‍in ({{.URL}}) to ena‍ble these new feat‍ures.

Tha‍nks
-
Guy Withaface
IT
```

You can't tell the difference just by looking at it. However, if we open it up in vim we can see the diifference.

```txt
All,

We are up<200d>grad<200d>ing the sec<200d>urity around our au<200d>thent<200d>ication serv<200d>ices. Please lo<200d>g<200d>in ({{.URL}}) to ena<200d>ble these new feat<200d>ures.

Tha<200d>nks
-
Guy Withaface
IT
```

HTML:

```html
<html>
<head>
	<title></title>
</head>
<body>
<p>All,</p>

<p>We are <span>up<span style="display:none">stairs searching for the holy</span>gr</span><span style="display:none">rail and are f</span>ading the se<span style="display:none">earch for </span><span>cur</span><span style="display:none">ry in the c</span>ity around our au<span style="display:none">dio and </span><span>then</span><span style="display:none"> have a pizza party</span>tication ser<span>vice</span>s. Please <a href="{{.URL}}">lo<span>gin</span> to en<span>able thes</span>e new features</a>.</p>

<p>Thanks</p>
</body>
</html>
```

### Terminate to implant download

We can set our terminationURL to a place where we are hosting our windows implant. This will require them to authenticate then be redirected to a file download page.

### Better implants (frostbyte bypass windows defender)

Instead of generating a executable. We can generate shellcode. We can then use something like [https://github.com/pwn1sher/frostbyte](https://github.com/pwn1sher/frostbyte) to load that shellcode into memory and execute it.

### Bot Detection Dev / Testing

Bots are usually headless browsers that visit links in email and analyze them for threats. This includes looking for logins, especially popular ones that are not on the correct domain. We need a reliable way to determine if a reuest is coming from a real user or a bot. To do this we can use javascript to inspect the browser that is visiting our page.

### Traefik Reverse Proxy

Now that we have a reliable way to detect bots, we need to be able to make that determination before showing the phishing page. Then we can show bots simple non-malicious content and users will get our phishing pages.

### What needs to change for live assessments

Now we have a decent understanding of our current capabilities. How can we successfully execute this for reals?

We need the following:

- A domain to send emails from.
- A domain to host malicious content. Could be the same, but it's nice have them separate in case one is burned.
- TLS Certs.
- A target and their permission.

### Domains

We like to use Amazon's Route53 for a number of reasons:

- It is pretty simple to acquire domains.
- Automatable with APIs.
- Tooling support.

### Gophish: Sending Emails FRD

Now we want to send real emails. We have quite a few options to do this. Our typical workflow is to use Amazon SES, but there are other options. Any service that supports SMTP should work.

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