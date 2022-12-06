module "customer-api"{
  source                        = "../modules/resources/ecr"
  repo_name                     = "${var.environment}/${local.java_app_application_name}"
  application                   = local.java_app_application_name
  environment                   = var.environment
  max_images                    = 30
}