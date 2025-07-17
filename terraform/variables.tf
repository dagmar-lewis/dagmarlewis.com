variable "project_name" {
  description = "Project name"
  type = string
  default = "dagmarlewis.com"
}
variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "us-east-1"
}

variable "files_bucket_name" {
  description = "Default region for provider"
  type        = string
  default     = "dagmarlewis.com-tf-files"
}

variable "instance_type" {
  description = "Default ec2 instance type"
  type = string
  default = "t2.micro"
}

variable "ami" {
  description = "Default ec2 ami"
  type = string
  default = "ami-020cba7c55df1f615"
}

variable "vpc_cidr_block" {
  description = "Default vpc cidr block"
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "Default subnet cidr block"
  type = string
  default = "10.0.1.0/24"
}

variable "cloudfront_distrubution_state" {
  description = "Set state fro cloudfront distribution"
  type = bool
  default = false
}