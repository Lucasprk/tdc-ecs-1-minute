module "customer-api"{
  source                        = "../modules/resources/ecr"
  repo_name                     = "${var.environment}/${local.customer_api_application_name}"
  application                   = local.customer_api_application_name
  environment                   = var.environment
  max_images                    = 30
}

module "notification-api"{
  source                        = "../modules/resources/ecr"
  repo_name                     = "${var.environment}/${local.notification_api_application_name}"
  application                   = local.notification_api_application_name
  environment                   = var.environment
  max_images                    = 30
}

module "login-api"{
  source                        = "../modules/resources/ecr"
  repo_name                     = "${var.environment}/${local.login_api_application_name}"
  application                   = local.login_api_application_name
  environment                   = var.environment
  max_images                    = 30
}