# Route 53 - Managed DNS

## Overview

- In AWS, the most records ares:
    - A: hostname -> IPv4
    - AAAA: hostname -> IPv6
    - CNAME: hostname -> another hostname
    - Alias: hostname -> AWS resource

- Route 53 can use:
    - Public domain name you own:
    - Private domain names that can be resolved by your instances in your VPCs

- Features:
    - Load balancing
    - Health check
    - Routing policy: simple, failover, geolocation, weighted, multi value

- You pay $0.5 per month per hosted zone
