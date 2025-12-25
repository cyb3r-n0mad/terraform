Build an environment from scratch. 


## Built file structure



## in envs/dev

set providers.tf

set variables.tf

set terrform.tfvar


## Then when to Modules / VPC

set main.tf for vpc & subnet

set variables.tf

set outputs.tf

## Now adding a call to the modules in env/devs main.tf

add module and link via relative file path

Add information for declared variables in the variables file in vpc directoy


## Testing 

perform terraform fmt and correct any errors - fmt checks to make sure the structure of the files is good. 
    - I missed comma between subnet ranges
    - I mised putting the cidr range in "" 


I ran tflint with 0 results - tflint checks the code for syntaxz mistakes, variable mistages

I ran tfsec and had 2 results - tfsec checks the code for security vulnerabilities
    - High - Instances in a subnet should not get a public IP
    - Medium - We dont have VPC flow log enabled so we cannot see as much traffic moving.
Both are acceptable for this test environment. 

terraform validate - check the code for a valid configuration file

terraform plan - check the code vs the environment to see what will change and how. Allows you tgo review before applying, as well as output the plan for peer and change board review

Plan showed that I forgot to put myaws profile information in the providers.tf file
    - added a line in providers for a variable called aws profile
    - added the variable in variables file for aws profile
    - updated the tfvar file 

Retested all steps

## Plan

Plan is to create a vpc with 2 subnets. 

This looks good so we will apply, and look for changes in the console. 

## Apply 

verified that the vpc and subnets were built as expected in us-east-2

Moving on to EC2-Linux

# built Module

built the basic linux main .tf deployument

built the variables file for a ec2 eployment

# Updating environment with ec2 linux

Set name, ami, size, and subnet deployment


# testing

fmt = good 
tflint = invalid expression on ec2-linux main line8. stand bny
    - accidentally entered two  = = signs. deleted save 
    - now tflint is clean
tfsec - tf sec check all security in entire deployment but we got new ones with the ec2 instances - easier to read in vsc side bar, refresh at top
    - High
        - ec2 ecryption at rest
        - es2 enforce http token imds
        - ec2 no public ip subnet
    - medium
        - flow logs

terrafrom validate
    - got an error the linux-ec2 module was not installed
    - i created it AFTER the last time is ran the terraform INIT command
    - re ran and now says i'm good on init
    - now configuration is valid

terraform plan

Terraform apply

Success!

## Building windows deploy

Copied linux module and variables

## edit /env/dev

in env/dev main.tf  I copied the same block used for linux. 

I updated the instance name and the ami for a windows server 2025 base

and i set subnet to 1 to put in the 10.0.2.0/24 subnet
code reuse. 

## Testing

fmt good
tflint good
tfsec - nothing new

tried to terrafrom init due to new module but didnt change module name & path in dev/main.tf  update that save and try again

terraform initialized

terraform validate = good

Terraform plan = good

terraform apply 

Windows server built and in correct subnet

 # S3 storager build

 If you set variables first, vsc will autofill when your creating your main.tf file and blocks

 Set module outputs, and dev outputs
 
 # testing for s3 deploy

 terraform init - good

 terraform fmt - good

 tflint - good

 tfsec - good
    more findings for s3. block public acls, block public policy, enable encryption, encryption costomer key, ignor public acls, no public accees, enable vuket logging, specify builic access block

 terraform validate 
    - syntax error in s3/main.tf  - easy fix


 terraform plan

 - plan showed 2 changes. I didnt understand at first
 but it looks liek change one is creating the bucket, and change is enabling versioning

 terraform apply
 - another syntax error, only lower case in bucket names


It was successful

with a environment output set, it provided the bucket arn at the end as specified. 
