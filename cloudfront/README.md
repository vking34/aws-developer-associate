# CloudFront

## Overview

- Content Delivery Network (CDN) improves read performance, content is cached at the edge

- Can expose external HTTPS and can talk to internal HTTPS backends

## Origins

- S3 bucket
    - For distributing files and caching them at the edge
    
    - Enhanced security with CloudFront Origin Access Identity (OAI)

    - CloudFront can be used as an ingress (to upload files to S3)

- Custom Origin (HTTP)
    - Application Load Balancer (ALB)

    - EC2 instance

    - S3 static website

    - Any HTTP backend u want

## Work with S3

- Create S3

- Create CloudFront distribution

- Create Origin Access Identity

- S3 bucket to be accessed only using this identity

## Caching

- Cache based on:
    - Headers
    - Session Cookies
    - Query String Parameters

- The cache lives at each CloudFront __Edge Location__

- Invalidate part of cache using CreateInvalidation API

## Security

- Origin Access Identity (OAI)

- Geo Restriction:
    - Whitelist
    - Blacklist

    - Use case: Copyright laws to control access to content

- HTTPS
    - Viewer Protocol Policy
    - Origin Protocol Policy

## Signed URL / Signed Cookies

- Distribute paid shared content to premium users over the world

- Policies:
    - Expiration
    - IP ranges to access the data from
    - Trusted signers (which AWS accounts can create signed URLs)

- TTL:
    - Shared content: short (a few min)
    - Private content: long (years)

- Signed URL = individual files
- Signed Cookies = multiple files