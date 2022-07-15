terraform {
  required_version = ">= 0.14.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  backend "s3" {
    bucket = "lpb-terraform-state"
    region = "ap-southeast-2"
  }

}

#Provider profile and region in which all the resources will create
provider "aws" {
  profile = "default"
  region  = var.region
}