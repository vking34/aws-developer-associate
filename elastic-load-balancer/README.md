# Elastic Load Balancer - ELB

## Load Balancing

- Load balancers are servers that forward internet traffic to multiple servers downstream.

## Why use a load balancer?

- Spread load across multiple downstream instances

- Expose a single point of access (DNS) to the application

- Seamlessly handle failures of downstream instances

- Do regular health checks to your instances

- Provide SSL termination (HTTPS) for your websites

- Enforce stickness with cookies

- High availability across zones

- Separate public traffic from private traffic

## Why ELB?

- ELB is a managed load balancer

- AWS guarentees that it will be working

- AWS takes care of upgrades


## Types

- 3 types of managed LB:
    - __Classic Load Balancer__ (v1 - old generation - 2009):
        - HTTP, HTTPS, TCP

        - Fixed hostname: xxx.region.elb.aws.com

    - __Application Load Balancer__ (v2 - new generation - 2016)*:
        - HTTP, HTTPS(/2), Websocket

        - Load balancing to multiple HTTP application across machines (target groups)

        - Load balancing to multiple applications on the same machine (ex: containers)

        - Fixed hostname


    - __Network Load Balancer__ (v2 - new generation - 2017):
        - TCP, TLS, UDP

        - To instances

        - Handle millions of request per seconds

        - Less latency ~ 100ms (vs 400ms for ALB)

        

- You can setup __internal__ or __external__ ELB

## Troubleshooting

- Load Balancer Error 503 means at capacity (overload) or no registered terget

- If LB can not connect to your application, check your security groups


## Checklist

