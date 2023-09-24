terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.17.0"
        }

        local = {
        source  = "hashicorp/local"
        version = "~> 2.4.0"
        }
    }
    backend "s3" {
        bucket = "terraform-state"
        key    = "terraform.tfstate"
        region = "us-east-2"
      
    }
}

provider "aws" {
    region = "us-east-2"
}