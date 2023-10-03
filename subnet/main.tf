terraform {
  cloud {
    organization = "024_2023-summer-cloud"

    workspaces {
      name = "infra-subnet"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

variable "vpc_id" {
  default = "vpc-0bb08df1093ea4c4f"
}

data "aws_vpc" "main" {
  id = var.vpc_id
}

resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.main.id
  cidr_block = cidrsubnet(data.aws_vpc.main.cidr_block, 4, 1)

  tags = {
    Name = "Main"
  }
}