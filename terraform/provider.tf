terraform {
  # backend "s3" {
  #   bucket = "dagmarlewis.com-tf-state"
  #   key = "dagmarlewis.com-terraform.tfstate"
  #   region = "us-east-1"
  #   dynamodb_table = "dagmarlewis.com-tf-state-locking"
  #   encrypt = true
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}

provider "aws" {
  region = var.region
}