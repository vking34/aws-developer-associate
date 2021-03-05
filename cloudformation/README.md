# CloudFormation

## Infrastructure as Code

- Code would be deployed and create / update / delete our infrastructure


## Definition

- CloudFormation is a declarative way of outlining your AWS infrastructure, for any resources (most of them are supported)

- CloudFormation creates resources for you in the right order with the exact configuration that you specify

## Benefits

- Infrastructure as Code

    - No resources are manually created, which is excellent for control
    - Code can be version controlled for example using git
    - Changes to the infrastructure are reviewed through code

- Cost:
    - Each resources within the stack is stagged with an identifier so you can easily see how much a stack costs you

    - Estimate the costs of your resources using the CloudFormation template
    - Saving strategy: in dev, you could automation deletion of templates at 5 PM and recreated at 8 AM safely

- Productivity:
    - Ability to destroy and recreate an infrastructure on the cloud on the fly
    - Automated generation of Diagram for your templates
    - Declarative programming (no need to figure out ordering and orchestration)

- Separation of concern: create many stacks for many apps and many layers

- Dont re-invent the wheel
    - Leverage existing templates on the web
    - Leverage the documentation

## How CloudFormation works

- Templates have to be uploaded in S3 and then referenced in CloudFormation

- To update a template, we cant edit previous ones. We have to re-upload a new version of template to AWS

- Stacks are identified by a name

- Deleting a stack deletes every single artifact that was created by CloudFormation

## Building Blocks

- Template components:
    - __Resources__: (Mandatory)
    - Parameters
    - Mappings
    - Outputs
    - Conditionals
    - Metadata

- Templates helpers
    - References
    - Functions