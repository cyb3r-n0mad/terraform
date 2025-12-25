# s3 module variables

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type = string
}

variable "force_destroy" {
  description = "Allow Terraform to destroy bucket with objects"
  type = bool
  default = false
}

variable "versioning_enabled" {
  description = "Enable S3 versioning"
  type = bool
  default = true
}

variable "tags" {
  description = "Tags Applied to the bucket"
  type = map(string)
  default = {}
}