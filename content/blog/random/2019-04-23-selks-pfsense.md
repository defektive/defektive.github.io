---
date: "2019-04-23T16:20:01"
title: PfSense and SELKS
tags: [ random , PfSense , SELKS ]
---

I installed [SELKS](https://www.stamus-networks.com/2017/08/22/selks-4-0/) this in a VM. I am using Fedora Server (which
I kind of regret because of the updates).

Once installed I went to my PfSense firewall admin interface, to bridge LAN and WAN to a 3rd interface (
OPT1). [ref](https://www.techdodo.co.uk/adding-span-port-pfsense)

```
                   WAN
                   +
                   |
                   |
    +--------------v----------------+
    |                               |
    |                               |
    |           PfSense             |
    |                               |
    |                               |
    |                               |
    +---+--------------------+------+
        |                    |
        |                    |
        |                    |
        v                    v
       LAN                  OPT1
                   (to SELKS Monitor port)
```

### PfSense logs in SELKS kibana

I used some files from [here](https://github.com/patrickjennings/logstash-pfsense), then
enabled [log forwarding in pfsense](https://docs.netgate.com/pfsense/en/latest/monitoring/copying-logs-to-a-remote-host-with-syslog.html)
