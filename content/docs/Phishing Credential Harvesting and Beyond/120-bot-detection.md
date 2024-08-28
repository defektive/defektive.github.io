+++
title = "Bot Detection"
weight = 120
+++



### What are bots?

Bots are usually headless browsers that visit links in email and analyze them for threats. This includes looking for logins, especially popular ones that are not on the correct domain. We need a reliable way to determine if a request is coming from a real user or a bot. 

### How can we detect bots?

To do this we can use javascript to inspect the browser that is visiting our page. There are a number of decent articles out there on how to do this. We'll use what minimum to detect urlscan.io. 

Example test script for enumerating bots. We are using urlscan.io to screenshot it and read the output. However, if we were testing email bots, we'd probably want to send this information to a server so we could analyze it.

```js
<script>
function botCheck (isBotFn, isNotBotFn) {

    let dumbtimeoutRan = false;
    window.setTimeout(function () {
        dumbtimeoutRan = true;
    }, 1500);

    let defaultTimeout = 1200;
    let startTime = new Date().getTime();

    window.setTimeout(function () {
        let execTime = new Date().getTime();
        let timeoutDiff = execTime - startTime;

        // Check notifications
        navigator.permissions.query({name:'notifications'}).then(function(permissionStatus) {
            let data = {
                notificationsDisabled: Notification.permission === 'denied' && permissionStatus.state === 'prompt' && 1,
                headlessUA: /HeadlessChrome/.test(window.navigator.userAgent),
                timeoutDiff: timeoutDiff,
                defaultTimeout: defaultTimeout,
                dumbtimeoutRan: dumbtimeoutRan,
                evalString: eval.toString().length,
                screenOffset: window.screenX + window.screenY,
                windowwidth: window.screen.width,
                windowheight: window.screen.height,
                windowavailWidth: window.screen.availWidth,
                windowavailHeight: window.screen.availHeight,
                windowavailTop: window.screen.availTop,
                windowavailLeft: window.screen.availLeft,
                windowcolorDepth: window.screen.colorDepth,
                windowpixelDepth: window.screen.pixelDepth,
                userAgent: window.navigator.userAgent,
            }

            document.write(JSON.stringify(data).replaceAll(',"', ',<br>"'))
        });
    }, defaultTimeout);
}

botCheck(handleBot, handleNotBot);
</script>
```


![URLScan.io Screenshot](/static/how-to-phishing/urlscan-screenshot.png)

We've collected some decent metrics from the URL scan headless browser. We can see that the screen offset it 0. This means that the browser is on the top left corner of the desktop. We'll use that as our simple check for now. However, many mobile browsers will report the same thing, so this isn't a catch all solution. We'd need to spend some time capturing metrics from different bots and real browsers to come up with a decent bot detector.

Lets simplify our Javascript to just what we need.

```js
<script>
function botCheck (isBotFn, isNotBotFn) {
    let isBot = swindow.screenX + window.screenY;

    if (isBot) {
        isBotFn.call(window, 1)
    } else {
        isNotBotFn.call(window, data)
    }
}

function handleBot (data) {
    // only bots should execute this
    document.write("hi bot!")
}


function handleNotBot (data) {
    // Non-bots should execute this. 
    document.write("Hello Human!")
}

botCheck(handleBot, handleNotBot);
</script>
```