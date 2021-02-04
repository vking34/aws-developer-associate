# Elastic Load Balancer - ELB


## Cross-Zone Load Balancing

- Cross Zone Load Balanacing: each load balancer instance distributes evenly across all registered instances in all AZ

- Classic Load Balancer:

    - Disabled by default

    - Enabled:
        - No charges for inter AZ
        - Charges for 

- Application Load Balancer:
    
    - Enabled by default

    - No charges for inter AZ

- Network Load Balancer:
    
    - Disabled by default

    - No charges for inter AZ

## SSL/TLS

- TLS (Transport Layer Security) is a newer version of SSL (Secure Socket Layer)

- Public SSL certificates are issued by CA

- You can manage certificates using ACM

- SNI (Server Name Indication) solves problem of loading multiple SSL certificates onto one web server (to serve multiple websites)

- Its a newer protocol and requires the client to indicate the hostname of the target server in the initial handshake. The server will then find the correct certificate, or return default one.

- CLB:
    - Support only one SSL cert

- ALB, NLB:
    - Support SNI, multiple SSL based on Security Group

## Connection Draining

- Stop sending new requests to the instance which is draining, de-registering, unhealthy.

- New connections will establish to all other instances.

#
