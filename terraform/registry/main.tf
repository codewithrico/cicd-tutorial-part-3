terraform {
  required_version = ">= 1.0.11"
  backend "s3" { /* See the backend config in config/backend-config.tf */ }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.68.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
}

variable "registry_name" {
  type = string
}

variable "aws_region" {
  type = string
}

provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "repository" {
  name                 = var.registry_name
  image_tag_mutability = "MUTABLE"
  tags                 = {
    Name = var.registry_name
  }

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "registry_id" {
  description = "The account ID of the registry holding the repository."
  value = aws_ecr_repository.repository.registry_id
}

output "repository_name" {
  description = "The name of the repository."
  value = aws_ecr_repository.repository.name
}

output "repository_url" {
  description = "The URL of the repository."
  value = aws_ecr_repository.repository.repository_url
}

