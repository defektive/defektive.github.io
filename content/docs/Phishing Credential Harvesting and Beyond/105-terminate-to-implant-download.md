+++
title = "Modlishka Terminate to Implant Download"
weight = 105
+++


### Terminate to implant download

We can set our terminationURL to a place where we are hosting our windows implant. This will require them to authenticate then be redirected to a file download page.

Lets add our newly generated payload to the ngix container.

```bash


```

Create a landing page html to be our termination URL. We can use this to execute some js to make sure the target is running windows before we download the file.

```html


```

update modlishka's termination URL.

TODO: Screenshot


Test it out with modlishkla

```bash
sudo docker compose up
```

Create a new campaign and test it out.


