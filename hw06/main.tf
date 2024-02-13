variable "region" {
  description = "The AWS region to deploy into"
  type        = string
  default     = "eu-central-1"
}

variable "accountId" {
  description = "The AWS account ID"
  type        = string
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}
