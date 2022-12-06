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
  customer_api_application_name = "customer-api"
  notification_api_application_name = "notification-api"
  login_api_application_name = "login-api"
  cluster_name = "${var.environment}-backend-apis"
}