+++
title = "Basic Credential Harvesting"
weight = 35
+++

## Create a new landing page.
- open https://someplace.okta.com/
- open dev console (f12)
- in console run:
```js
let s = document.getElementsByTagName('script'); while (s[0]) { s[0].parentNode.removeChild(s[0])}
```

![Basic Credential Harvesting Landing Page](/static/how-to-phishing/basic-cred-harvest-landing-page-dev-console.png)

- right click web page > inspect element.
- find top HTML tag.
- right click > copy > outer HTML.

![Copy Outer HTML](/static/how-to-phishing/basic-cred-harvest-landing-page-html-copy-outer-html.png)

- paste HTML in landing page.
- check capture data.
- check capture password.
- set redirect to https://www.okta.com/404.html

![Gophish Landing Page](/static/how-to-phishing/gophish-landing-page-creation.png)

## Create a new email template

Be sure to include `{{.URL}}` [ref](https://docs.getgophish.com/user-guide/template-reference)

- Name: `Basic credential Harvesting`
- Envelope Sender: `guy@target.docker`
- Subject: `Account Security Feature Upgrade`

Text:

```txt
All,

We are upgrading the security around our authentication services. Please login ({{.URL}}) to enable these new features.

Thanks
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

<p>We are upgrading the security around our authentication services. Please <a href="{{.URL}}">login to enable these new features</a>.</p>

<p>Thanks</p>
</body>
</html>
```

![Basic Credential Harvesting Email Template Creation](/static/how-to-phishing/gophish-basic-template-creation.png)

## Create a new group to be our target

We can download the CSV template and populate it with our users we found earlier. Then import the CSV template.

![New Gophish Group](/static/how-to-phishing/gophish-new-group.png)

- Create new Campaign that uses the above.
  - Use `http://gophish.docker/this/path/doesnt/matter` for the URL.

![Basic Credential Harvesting Campaign](/static/how-to-phishing/basic-cred-harvest-campaign.png)

### Test email in MailHog

- Open MailHog
- click link.
![First Email](/static/how-to-phishing/first-email.png)
![First Landing Page](/static/how-to-phishing/first-landing-page.png)

- attempt to login with fake credentials.
![First Campaign Results](/static/how-to-phishing/first-campaign.png)