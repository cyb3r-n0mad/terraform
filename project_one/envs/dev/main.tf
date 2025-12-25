
#env/dev

# referenceing the as built vpc module
module "vpc" {
  source = "../../modules/vpc"

  # Assigning the values to the variable in the VPC directtory
  name = "dev-vpc"     # name of the VPC
  cidr = "10.0.0.0/16" # Full range of the VPC
  public_subnets = [
    "10.0.1.0/24", # Range of public subnet 1
    "10.0.2.0/24"  # Range of public subnet 2
  ]

}

# referencing ec2-linux module 

module "linux-ec2" {
  source = "../../modules/ec2-linux" #build module

  name          = "dev-linux"                     # name
  ami           = "ami-0e858a9b9fb8b4917"         # amazon machine image, Amazon Linux 2
  instance_type = "t3.micro"                      # resources for machine   
  subnet_id     = module.vpc.public_subnet_ids[0] # subnet id 0 = 10.0.1.0/24 subnet


}

# referencing ec2-windows module 

module "windows-ec2" {
  source = "../../modules/ec2-windows" #build module

  name          = "dev-windows"                   # name
  ami           = "ami-013e43c5ba6d06126"         # amazon machine image, Microsoft server 2025 base
  instance_type = "t3.micro"                      # resources for machine   
  subnet_id     = module.vpc.public_subnet_ids[1] # subnet id 0 = 10.0.1.0/24 subnet id 1 = 10.0.2.0/24


}

# referenceing s3 bucket module

module "logs_bucket" {
  source = "../../modules/s3"

  bucket_name        = "charlotte-dev-log-testing"
  force_destroy      = true
  versioning_enabled = true

  tags = {
    Environment = "dev"
    Owner       = "charlotte"
    Purpose     = "logs"
  }
}

