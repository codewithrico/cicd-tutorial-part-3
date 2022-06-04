terraform {
  required_version = ">= 1.0.11"
  backend "s3" { /* See the backend config in config/backend-config.tf */ }

  required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 3.68.0"
		}
		datadog = {
			source = "DataDog/datadog"
			version = "3.8.1"
		}
		random = {
			source  = "hashicorp/random"
			version = "~> 3.1.0"
		}
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Application = var.service_name
      Terraform  = true
    }
  }

  skip_credentials_validation = true
  skip_metadata_api_check     = true
}

