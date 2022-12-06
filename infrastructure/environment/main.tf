terraform {
  backend "s3" {}
}

provider "aws" {
  region = var.region
  profile = var.profile
}

provider "aws" {
  alias = "virginia"
  region = "us-east-1"
  profile = var.profile
}

locals {
  sg_rule_all_ip = ["0.0.0.0/0"]
  java_app_application_name = "customer-api"
  cluster_name = "${var.environment}-backend-apis"
}