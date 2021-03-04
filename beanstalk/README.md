# Beanstalk

## 3 architecture models:

- Single Instance deployment: good for dev
- LB + ASG: great for production
- ASG only: great for non-web apps in production (workers, ...)

## 3 Components:

- App
- App version: each deployment gets assigned a version
- Environment name: dev, test, prod, ...

## Deployment Modes

- Single Instance: great for dev
- High Avaibility with Load Balancer: great for prod

## Deployment Strategies

- __All at once__:
    - Fastest deployment
    - Great for quick iterations in development env
    - No additional cost
    - Downtime

- __Rolling__:
    - Running both version simultaneously
    - No additional cost
    - Long deployment

- __Rolling with additional batches__: like rolling, but spins up new instances to move the batch (so that the old application is still available)
    - Can set the bucket size
    - Running both versions simultaneously
    - Small additional cost
    - Additional batch is removed at the end of the deployment
    - Good for prod
    - Longer deployment
    
- __Immutable__: spins up new instances in a new ASG, deploys version to these instances and then swaps all the instances when everything is healthy
    - Zero downtime
    - New code is deployed to new instances on temporary ASG
    - Quick rollback in cast failures (just terminate new ASG)
    - Great for pod
    - High cost, double capacity
    - Longest deployment

- __Blue/Green__:
    - Not a direct feature of Beanstalk
    - Zero downtime and release facility
    - Create a new "stage" environment and deploy v2 there
    - The new environment (green) can be validated independently and roll back if isses
    - Route 53 can be setup using weighted polices to redirect a little of traffic to the stage env
    - Using beanstalk, swap URLs when done with the env test

## Beanstalk CLI

- We can install an additional CLI called the EB CLI which makes working with beanstalk from CLI easier

- Helpful for you automated deployment pipelines (for DevOps)

## Deployment Process

- Describe dependencies (requirements.txt, package.json)

- Package code as zip and describe dependencies

- Console, CLI create new app version and then deploy zip

- Deploy the zip on each EC2 instance, resolve dependencies and start the app

## Lifecycle Policy

- Beanstalk can store at most 1000 app versions
- To phase out old app versions, use lifecycle policy
    - based on time
    - based on space

- Versions that currently used wont be deleted
- Option not to delete the source bundle in S3 to prevent data loss

## Extensions

- A zip file containing our code must be deployed to Beanstalk
- All the parameters set in UI can be confgured with code using files
- Requirements:
    - in the .ebextensions/ directory in the root of source code
    - YAML /JSON format
    - .config extensions
    - Modify some default setting using: option_settings
    - Add resources such as RDS, ElastiCache, DynamoDB, ...

- Resources managed by .ebextensions get deleted if environment goes away

## CloudFormation

- Beanstalk relies on CloudFormation
- CloudFormation is used to provision other AWS services
- Use case: define CloudFormation resources in your ebextensions to provision ElasticCache, S3, ...

## Mirgration

- Load balancer:
    - Create a new env with same config except LB (not clone)
    - Deploy your app onto new env
    - perform a CNAME swap or Route 53 route

- RDS:
    - Create snapshot of RDS DB (as safeguard)
    - RDS console and protect the RDS db from deletion
    - Create new env without RDS, point your app to existing RDS
    - Perform a CNAME swap or Route 53 update
    - Terminate the onld env (RDS wont be deleted)


## With Docker

### Single Docker

- 2 lauch types:
    - Dockerfile
    - Dockerrun.aws.json

- Beanstalk in single docker container __does not use ECS__

### Multi Docker

- Multiple containers per EC2 instance in EB

- This will create:
    - ECS cluster
    - EC2 instances, configured to use the ECS cluster
    - Load balancer
    - Task definition and execution

- Requires a config Dockerrun.aws.json at the root of source code

- Dockerrun.aws.json is used to generate the ECS task definition

- You docker images must be pre-built or stored in ECR

## Advanced concepts

- HTTPS:
    - Idea: Load the SSL cert onto the LB
        - Done from the console
        - Done from the code: .ebextensions/securelistener-alb.config
    
    - SSL cert can be provisioned using ACM or CLI
    - Must config a security group rule to allow incoming port 443

    - Beanstalk redirect HTTP to HTTPS
        - Configure your instances to redirect HTTP to HTTPS
        - Or config the ALB (only) with the rule
        - Make sure health checks are not redirected
    
- Web server vs Worker Env:
    - Decoupling your app into two tiers is common: Web Tier + Worker Tier
    - Example: processing a video, generating a zip
    - Define periodic tasks in a file cron.yaml

- Custom platform
    - Use case: app language is incompatible with Beanstalk and does not use docker
    - To create you own platform:
        - Define an AMI using platform.yaml
        - Build that platform using packer software
    
    - Custom platform vs custom image (AMI)
        - Custom Image is to tweak an existing beanstalk platform
        - Customer platform is create an entirely new beanstalk platform