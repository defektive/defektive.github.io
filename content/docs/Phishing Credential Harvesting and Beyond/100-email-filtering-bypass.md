+++
title = "Email Filtering Bypass"
weight = 100
+++


### Bypassing Email Filtering

A lot of times emails will be quarantined based on content. We can trick them by injecting invisible characters and html elements into our messages. 

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

You can't tell the difference just by looking at it. However, if we open it up in vim we can see the difference.

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