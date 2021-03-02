# S3

## Bucket

- Buckets (directories) must have a global unique name

- Buckets are defined at the region level


## Objects

- Objects (files) have a key

- The key is the full path:
    - s3://my-bucket/__file.txt__
    - s3://my-bucket/__myf-folder/file.txt__

- The key is composed of *prefix* + __object name__
    - s3://my-bucket/*myf-folder/*__file.txt__

- No concept of directories with buckets (although the UI will trick you to think otherwise)

- Object values:
    - Max object size: 5 TB
    - if uploading more than 5 GB, must be "multi-part upload"

- Metadata (list of text key/value pairs - system or user metadata)

- Tags: useful for security / lifecycle

- Version:
    - At the bucket level
    - Same key overwrite will increment the version: 1, 2, 3, ...

    - It is best practice to version your buckets:
        - Protect against unintended deletes
        - Easy roll back to previous version

    - Notes:
        - Any file that is not versioned prio to enabling versioning will have version "null"
        - Suspending versioning does not delete the previous versions, every next upload is not versioned.
    
## Encryption

- Server side:
    - SSE-S3:
        - Encryption using keys that are handled & managed by S3

        - Object is encrypted server side. SSE - Sever Side Encryption

        - AES-256 type

        - Must set header: "z-amz-server-side-encryption": "AES356"

    - SSE-KMS:
        - Encryption using keys handled & managed by KMS

        - KMS advantages: user control + audit trail 

        - Object is encrypted server side.

        - Must set header: "z-amz-server-side-encryption": "aws:kms"


    - SS3-C:
        - Server-side encryption using data keys fully managed by client outside of AWS

        - S3 does not store the encryption key you provide

        - __HTTPS must be used__

        - Key must be provideed in HTTP headers, for every HTTP request made

- Client Side:
    - Client Side Encryption:

        - Clients must encrypt data themselves before sending to S3
        - Client must decrypt data themselves when retrieving data from S3


- In transit:
    - S3 exposes:
        - HTTP
        - HTTPS (recommended)

    - HTTPS is mandatory for SSE-C


## Security

- User based:
    - IAM policies: which API calls should be allowed for a specific user from IAM console

- Resource Based:
    - Bucket Policies: bucket wide rules from the S3 console
    - Object Access Control List (ACL)
    - Bucket Access Control List 

- Notes: an IAM principal can access an S3 object if
    - the user IAM permissions allow it OR the resource policy ALLOWS it
    - AND there's no explicit DENY

- Networking:
    - Supports VPC endpoints

- Logging:
    - S3 access logs can be stored in other S3 bucket
    - API calls can be logged in AWS

- User Security:
    - MFA delete: MFA (multi factor authentication) can be required in versioned buckets to delete objects

    - __Pre-signed URL: URLs that are valid only for a limited time (ex: premium video service for logged in users)__


## Policy

- JSON based policies:
    - Resource: buckets and objects
    - Actions: set of API to Allow or Deny
    - Effect: Allow / Deny
    - Principal: the account or user to appl the policy to

- Use S3 bucket for policy to:
    - Grant public access to the bucket
    - Force objects to be encrypted at upload
    - Grant access to another account


- Bucket setting for Block public access:

    - Settings:
        - Block public access to buckets and objects granted through:
            - new ACL
            - any ACL
            - new public bucket or access point policies

        - Block public and cross-account access to buckets and objects through any public bucket or access point policies

    - The settings were created to prevent company data leaks

    - If you know your bucket should never be public, leave these on

    - Account level

## CORS

- An origin is a schema (protocol), host (domain), and port

![](../references/images/cors-00.png)

## Consistency Model

- Read after write consistency for POSTS of new objects

- Eventual Consistency for DELETES and PUTS of existing objects

    - If we read object after updating, we might get the older version

## Replication

- Must __enable versioning in source and destination__

- Cross Region Replication (CRR): compliance, lower latency access, replication across accounts

- Same Region Replication (SRR): log aggregation, live replication between production and test accounts

- Buckets can be in different accounts

- Copying is asynchronous

- Must give proper IAM permissions to S3

- After activating, only new objects are replicated (not retroactive)

- For DELETE operations:
    - a delete marker is not replicated (can be enabled)
    - deleted objects are not replicated

- No chaining of replication