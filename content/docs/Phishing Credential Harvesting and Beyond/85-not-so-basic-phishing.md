+++
title = "Not So Basic Credential Harvesting"
weight = 85
+++

Now we can go back to Gophish, clone our first credential harvesting campaign, modify the URL to point to Modlishka (http://modlishka.docker).

![Gophish Campaign with MFA](/static/how-to-phishing/not-so-basic-cred-harvesting-campaign.png)

This will break Gophish's Opened, Clicked, and Data Captured analytics. We can fix those later, but for now we'll just keep moving forward.

![MailHog MFA Campaign](/static/how-to-phishing/mailhog-mfa-campaign.png)

If we click on it, we can see in our Modlishka livewell page, we can see our target's RID.
 
![Modlishka Livewell Gophish RID](/static/how-to-phishing/modlishka-livewell-gophish-rid.png)

Feel free to go through the whole flow. It shouldn't be any different from the previous step besides the fact we are opening the link from an email instead of directly browsing to it.