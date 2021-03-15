# Security

## Encryption

- Encryption in flight (SSL)

- Server side encryption at rest

- Client side encryption

## KMS (Key Management Service)

- Anytime you hear "encryption" for an AWS service, its most likely KMS

- Easy way to control access to your data, AWS manages keys for us

- Full integrated with IAM for authorization

- Seamlessly integrated into:
    - EBS
    - S3
    - Redshift

    - RDS
    - SSM

- But u can also use the CLI/SDK

  
- Customer Master Key (CMK) types:

    - Symmetric (AES-256 keys)
        - First offering of KMS, single encryption key that is used to encrypt and decrypt

        - AWS services that are integrated with KMS use Symmetric CMKs

        - Neccessary for envelope encryption

        - You never get access to the key unencrypt (must call KMS API to use)

    - Asymmetric (RS & ECC key pairs)

        - Public (encrypt) and private key pair

        - Used for encrypt/decrypt or sign/verify operation
        - the public key is downloadable, but u cant access the private key unencrypted 

        - Use case: encryption outside of AWS by users who cant call the KMS API

- Fully manage the keys and policies:
    - Create

    - Rotation policies

    - Disable

    - Enable

- Audit key usage (using CloudTrail)

- Three types of Customer Master Keys (CMK)
    - AWS managed service default CMK: free

    - User keys created in KMS: $1/mon

    - User keys imported: $1/mon

    - pay for API call to KMS ($0.03/1000 calls)
    