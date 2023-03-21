provider "aws" {
  region                  = "eu-central-1"
  profile = "11me"
}

terraform {
  required_version = "~> 1.4.0"
  required_providers {
    aws = {
      version = "~> 4.20.0"
    }
  }
}
