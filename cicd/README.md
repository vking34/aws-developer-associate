# CICD

![](../references/images/code-pipeline-00.png)


## CodeCommit

- Private Git repositories
- Fully managed, highly available

- CodeCommit Security

    - Authentication:
        - SSH keys: users can config SSH keys in their IAM console
        - HTTPS: Done through the AWS CLI authentication helper or generating HTTPS credentials
        - MFA (multi factor authentication):

    - Authorization in Git:
        - IAM policies manage user / roles right to repositories
    
    - Encryption:
        - Repo are automatically encrypted at rest using KMS
        - Encrypted in transit (can only use HTTPS or SSH)

    - Cross Account access:
        - Do not share your SSH keys
        - Do not share your AWS credentials
        - Use IAM role in your AWS account and use AWS STS
    

- CodeCommit Notifications:
    - You can trigger notifications in CodeCommit using __SNS (Simple Notification Service) or Lambda or CloudWatch Event__

    - Use cases for SNS / Lambda notifấy
        - Trigger for pushes that happen in master branch
        - Notify external build system
        - Trigger Lambda function to perform codebase analysis

    - Use cases for CloudWatch Event rules:
        - Trigger for pull request updates
        - Commit comment event
        - CloudWatch Event Rules goes into an SNS topic


## CodePipeline

- Continous Delivery

- Visual workflow

- Source: Github / CodeCommit / Amazon S3

- Build: CodeBuild / Jenkins / etc ...

- Load Testing

- Deploy: AWS CodeDeploy / Beanstalk / CloudFormation / ECS

- Made of stages:
    - Each stage can have sequetail actions and/or parallel actions
    - Stages examples: Build / Test / Deploy / Load Test 
    - Manual approval cna be defined at any stage 

### Artifacts

- Each pipeline stage can create artifacts

- Artifacts are passed stored in S3 and passed on to the next stage

![](../references/images/code-pipeline-01.png)


### Troubleshooting

- CodePipeline state changes happen in CloudWatch Events, which can in return create SNS notifications
    - Ex: create events for failed pipelines
    - Ex: create events for cancelled pipelines

- If CodePipeline fails a stage, your pipeline stops and you can get information in the console

- AWS CloudTrail can be used to audit API calls

- If pipeline cant perform an action, make sure the IAM service role attached does have enough permissions (IAM policy)

## CodeBuild

- Build instructions can be defined in code (__buildspec.yml__)

- Output logs to S3 & CloudWatch logs

- Metrics to monitor CodeBuild statistics

- Use CloudWatch Alarm to detect failed builds and trigger notifications

- CloudWatch Events / Lambda as Glue

- SNS notifications
- Ability to reproduce CodeBuild locally to troubleshoot in case of errors

- Builds can be defined within __CodePipeline or CodeBuild itself__

### BuilSpec

- Define env:
    - Plaintext variables
    - Secure secret

- Phases (specify commands to run)
    - Install: install dependencies you may need for your build
    - Pre build: final commands to execute before build
    - Build:
    - Post build

- Artifacts: upload to S3 (encrypted with KMS)

- Cache: Files to cache (usually dependencies) to S3 for future build speedup

### CodeBuild in VPC

- By default, your CodeBuild containers are lauched outside your VPC

- Therefore, by default it cant access resources in a VPC

- You can specify a VPC configuration:
    - VPC ID
    - Subnet IDs
    - Security Group IDs

- Then your build can access resources in your VPC (RDS, EC2, ALB, ...)

- Use cases: integration tests, data query, internal load balancers

- Edit Env in CodeBuild project


## CodeDeploy

- Each EC2 machine (or on premise machine) must be running the CodeDeploy Agent

- The agent is continuously polling AWS CodeDeploy for work to do

- CodeDeploy sends __appspec.yml__

- App is pulled from github or S3

- EC2 will run the deployment instructions

- CodeDeploy Agent will report of success / failure of deployment on instance

- Support for AWS Lambda deployments

- CodeDeploy does not provision resources

- Hooks: set of instructions to do to deploy the new version (hooks can have timeouts). The order is:
    - ApplicationStop
    - DowloadBundle
    - BeforeInstall
    - AfterInstall
    - ApplicationStart
    - __ValidateService__: really important

### Configs

- Configs:
    - One a time: one instance at a time, one instance fails => deployment stops

    - Half at a time: 50%

    - All at once: quick but no healthy host, downtime. Good for dev

    - Custom: min healthy host = 75%

- Failures:
    - Instances stay in failed state
    - New deployments will first be deployed to failed state instances
    - To rollback: redeploy old deployment or enable automated rollback for failures

- Deployment targets:
    - Set of EC2 instances with tags
    - Directly to an ASG
    - Mix of ASG / tags so you can build deployment segments
    - Customization with scripts with DEPLOYMENT_GROUP_NAME env

### CodeDeploy to EC2

- Define how to deploy the application using appspec.yml + deployment strategy

- Will do in-place update to your fleet of EC2 instances

- Can use hooks to verify the deployment after each deployment phase

### CodeDeploy to ASG

- In place update

- Blue/Green deployment
    - a new ASG is created
    - how long to keep the old instances
    - Must be using ELB

### Roll Back

- Specify automated rollback options

- If a roll back happens, CodeDeploy redeploys the last known good revision as a __new deployment__

### CodeStar

- CodeStar is an integrated solution that regroups: Github, CodeCommit, CodeBuild, CodeDeploy, CloudFormation, CodePipeline, CloudWatch

- Helps quickly create CICD-ready projects for EC2, Lambda, Beanstalk