
# allows region to be set in tfvars fiel
variable "region" {
  type = string
}


# sets user profile for terraform credentials
variable "aws_profile" {
  type        = string
  description = "AWS CLI profile name"
}