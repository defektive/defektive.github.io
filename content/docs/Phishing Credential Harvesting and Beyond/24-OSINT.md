+++
title = "OSINT"
weight = 24
+++

Lets do some OSINT on our target....


```bash
host snakshare.com
```

We should see something like this.

```
➜  ~ host snakshare.com
snakshare.com has address 162.255.119.59
snakshare.com mail is handled by 10 eforward3.registrar-servers.com.
snakshare.com mail is handled by 20 eforward5.registrar-servers.com.
snakshare.com mail is handled by 15 eforward4.registrar-servers.com.
snakshare.com mail is handled by 10 eforward1.registrar-servers.com.
snakshare.com mail is handled by 10 eforward2.registrar-servers.com.
```

I like to do a reverse host look up.

```bash
host 162.255.119.59
```

But that gives us nothing....

```
➜  ~ host 162.255.119.59
Host 59.119.255.162.in-addr.arpa. not found: 3(NXDOMAIN)
```

lets do a whois on the IP address.

```bash
whois 162.255.119.59
```

This gives us lots of info.

```
➜  ~ whois 162.255.119.59

#
# ARIN WHOIS data and services are subject to the Terms of Use
# available at: https://www.arin.net/resources/registry/whois/tou/
#
# If you see inaccuracies in the results, please report at
# https://www.arin.net/resources/registry/whois/inaccuracy_reporting/
#
# Copyright 1997-2023, American Registry for Internet Numbers, Ltd.
#


NetRange:       162.255.116.0 - 162.255.119.255
CIDR:           162.255.116.0/22
NetName:        NCNET-5
NetHandle:      NET-162-255-116-0-1
Parent:         NET162 (NET-162-0-0-0-0)
NetType:        Direct Allocation
OriginAS:       AS16626, AS174, AS3356, AS4323, AS22612, AS32421
Organization:   Namecheap, Inc. (NAMEC-4)
RegDate:        2014-05-14
Updated:        2015-03-24
Comment:        http://namecheap.com
Comment:        for any abuse please use: abuse@namecheap.com
Ref:            https://rdap.arin.net/registry/ip/162.255.116.0


OrgName:        Namecheap, Inc.
OrgId:          NAMEC-4
Address:        11400 W. Olympic Blvd. Suite 200
City:           Los Angeles
StateProv:      CA
PostalCode:     90064
Country:        US
RegDate:        2011-01-28
Updated:        2017-01-28
Ref:            https://rdap.arin.net/registry/entity/NAMEC-4

ReferralServer:  rwhois://whois.namecheaphosting.com:4321

OrgAbuseHandle: ABUSE2885-ARIN
OrgAbuseName:   Abuse team
OrgAbusePhone:  +1-323-375-2822
OrgAbuseEmail:  abuse@namecheaphosting.com
OrgAbuseRef:    https://rdap.arin.net/registry/entity/ABUSE2885-ARIN

OrgTechHandle: EFIME-ARIN
OrgTechName:   Efimenko, Igor
OrgTechPhone:  +1-323-375-2822
OrgTechEmail:  igor.e@namecheap.com
OrgTechRef:    https://rdap.arin.net/registry/entity/EFIME-ARIN

OrgTechHandle: TECHT4-ARIN
OrgTechName:   Tech team
OrgTechPhone:  +1-323-375-2822
OrgTechEmail:  tech@namecheaphosting.com
OrgTechRef:    https://rdap.arin.net/registry/entity/TECHT4-ARIN


#
# ARIN WHOIS data and services are subject to the Terms of Use
# available at: https://www.arin.net/resources/registry/whois/tou/
#
# If you see inaccuracies in the results, please report at
# https://www.arin.net/resources/registry/whois/inaccuracy_reporting/
#
# Copyright 1997-2023, American Registry for Internet Numbers, Ltd.
#



Found a referral to whois.namecheaphosting.com:4321.

%rwhois V-1.0,V-1.5:00090h:00 billing.web-hosting.com (Ubersmith RWhois Server V-4.5.5)
autharea=162.255.119.0/24
xautharea=162.255.119.0/24
network:Class-Name:network
network:Auth-Area:162.255.119.0/24
network:ID:NET-79087.162.255.119.0/24
network:Network-Name:anycast-edge-fwd-range
network:IP-Network:162.255.119.0/24
network:IP-Network-Block:162.255.119.0 - 162.255.119.255
network:Org-Name:Web-hosting.com
network:Street-Address:900 N. Alameda St., Suite 220
network:City:Los Angeles
network:State:CA
network:Postal-Code:90012
network:Country-Code:US
network:Tech-Contact:MAINT-79087.162.255.119.0/24
network:Created:20190523133959000
network:Updated:20190523163000000
network:Updated-By:net-admin@namecheap.com
contact:POC-Name:Network team
contact:POC-Email:net-admin@namecheap.com
contact:POC-Phone:
contact:Tech-Name:Network team
contact:Tech-Email:net-admin@namecheap.com
contact:Tech-Phone:
contact:Abuse-Name:Abuse team
contact:Abuse-Email:abuse@namecheaphosting.com
%ok
```

We can see this IP address belongs to Namecheap. Probably sitting there for the default settings that redirect domain to the `www.` subdomain. Lets curl it.

```bash
curl -i snakshare.com
```

Yep! just a redirect to `www.snakshare.com`.

```
➜  ~ curl -i snakshare.com
HTTP/1.1 302 Found
Date: Fri, 20 Oct 2023 01:52:52 GMT
Content-Type: text/html; charset=utf-8
Content-Length: 48
Connection: keep-alive
Location: https://www.snakshare.com
X-Served-By: Namecheap URL Forward
Server: namecheap-nginx

<a href='https://www.snakshare.com'>Found</a>.
```

Lets repeat those steps for the `www` subdomain.

```bash
host www.snakshare.com
```

Lets examine the output.
```
➜  ~ host www.snakshare.com
www.snakshare.com is an alias for snakshare.github.io.
snakshare.github.io has address 185.199.109.153
snakshare.github.io has address 185.199.111.153
snakshare.github.io has address 185.199.108.153
snakshare.github.io has address 185.199.110.153
snakshare.github.io has IPv6 address 2606:50c0:8000::153
snakshare.github.io has IPv6 address 2606:50c0:8003::153
snakshare.github.io has IPv6 address 2606:50c0:8001::153
snakshare.github.io has IPv6 address 2606:50c0:8002::153
```

This looks a little different. We have an alias to `snakshare.github.io`. 

```bash
host 185.199.109.153
```

A host lookup on the IP reveals a github domain.
```
➜  ~ host 185.199.109.153
153.109.199.185.in-addr.arpa domain name pointer cdn-185-199-109-153.github.com.
```

We can doubly confirm, with a whois on the IP.

```bash
whois 185.199.109.153
```


```
➜  ~ whois 185.199.109.153
% This is the RIPE Database query service.
% The objects are in RPSL format.
%
% The RIPE Database is subject to Terms and Conditions.
% See https://apps.db.ripe.net/docs/HTML-Terms-And-Conditions

% Note: this output has been filtered.
%       To receive output for a database update, use the "-B" flag.

% Information related to '185.199.108.0 - 185.199.111.255'

% Abuse contact for '185.199.108.0 - 185.199.111.255' is 'abuse@github.com'

inetnum:        185.199.108.0 - 185.199.111.255
netname:        US-GITHUB-20170413
country:        US
org:            ORG-GI58-RIPE
admin-c:        GA9828-RIPE
tech-c:         NO1444-RIPE
status:         ALLOCATED PA
mnt-by:         RIPE-NCC-HM-MNT
mnt-by:         us-github-1-mnt
created:        2017-04-13T15:36:35Z
last-modified:  2018-12-14T10:48:39Z
source:         RIPE

organisation:   ORG-GI58-RIPE
org-name:       GitHub, Inc.
country:        US
org-type:       LIR
address:        88 Colin P. Kelly Jr. Street
address:        94107
address:        San Francisco
address:        UNITED STATES
phone:          +1 415 735 4488
admin-c:        GA9828-RIPE
tech-c:         NO1444-RIPE
abuse-c:        AR39914-RIPE
mnt-ref:        us-github-1-mnt
mnt-by:         RIPE-NCC-HM-MNT
mnt-by:         us-github-1-mnt
created:        2017-04-11T08:28:46Z
last-modified:  2020-12-16T13:16:10Z
source:         RIPE # Filtered

role:           GitHub Admin
address:        88 Colin P. Kelly Jr. Street
address:        94107
address:        San Francisco
address:        UNITED STATES
nic-hdl:        GA9828-RIPE
mnt-by:         us-github-1-mnt
created:        2017-04-18T22:16:30Z
last-modified:  2017-04-18T22:18:03Z
source:         RIPE # Filtered
abuse-mailbox:  abuse@github.com
org:            ORG-GI58-RIPE

role:           GitHub Network Operations
address:        88 Colin P. Kelly Jr. Street
address:        94107
address:        San Francisco
address:        California
address:        UNITED STATES
nic-hdl:        NO1444-RIPE
mnt-by:         us-github-1-mnt
created:        2017-04-18T20:05:01Z
last-modified:  2017-04-18T22:19:53Z
source:         RIPE # Filtered
org:            ORG-GI58-RIPE
admin-c:        GA9828-RIPE
abuse-mailbox:  abuse@github.com

% Information related to '185.199.109.0/24AS36459'

route:          185.199.109.0/24
origin:         AS36459
mnt-by:         us-github-1-mnt
created:        2017-04-18T21:02:25Z
last-modified:  2017-04-18T21:02:25Z
source:         RIPE
org:            ORG-GI58-RIPE
descr:          GitHub - 185.199.109.0/24

organisation:   ORG-GI58-RIPE
org-name:       GitHub, Inc.
country:        US
org-type:       LIR
address:        88 Colin P. Kelly Jr. Street
address:        94107
address:        San Francisco
address:        UNITED STATES
phone:          +1 415 735 4488
admin-c:        GA9828-RIPE
tech-c:         NO1444-RIPE
abuse-c:        AR39914-RIPE
mnt-ref:        us-github-1-mnt
mnt-by:         RIPE-NCC-HM-MNT
mnt-by:         us-github-1-mnt
created:        2017-04-11T08:28:46Z
last-modified:  2020-12-16T13:16:10Z
source:         RIPE # Filtered

% This query was served by the RIPE Database Query Service version 1.108 (SHETLAND)
```