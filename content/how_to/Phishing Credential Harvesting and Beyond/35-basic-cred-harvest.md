+++
title = "Basic Credential Harvesting"
weight = 35
+++


- Create a new landing page.
  - open https://someplace.okta.com/
  - open dev console (f12)
  - in console run:
  ```js
  let s = document.getElementsByTagName('script'); while (s[0]) { s[0].parentNode.removeChild(s[0])} 
  ```
  - right click web page > inspect element.
  - find top HTML tag.
  - right click > copy > outer html.
  - paste html in landing page.
  - check capture data.
  - check capture password.
  - set redirect to https://www.okta.com/404.html
- Create a new email template, be sure to include `{{.URL}}`
  - https://docs.getgophish.com/user-guide/template-reference
- Create a new group to be our target.
- Create new Campaign that uses the above.
  - Use `http://127.0.0.2/this/path/doesnt/matter` for the URL.

![Basic Credential HArvesting Campaign](/static/how-to-phishing/basic-cred-harvest-campaign.png)

### Test email in Mailhog

- Open Mailhog
- click link.
![First Email](/static/how-to-phishing/first-email.png)
![First Landing Page](/static/how-to-phishing/first-landing-page.png)

- attempt to login with fake creds.
![First Campaign Results](/static/how-to-phishing/first-campaign.png)