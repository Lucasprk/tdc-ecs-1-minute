terraform {
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

module "application_logs"{
  source                        = "../../resources/cloudwatch"
  log_group_name                = "/${var.environment}/${var.application.name}"
  log_retention_in_days         = var.application.log_retention_days
  application                   = var.application.name
  environment                   = var.environment
}

module "application_target_group" {
  source                      = "../../resources/target-group"
  tg_name                     = "${var.environment}-${substr(replace(lower(var.application.name), "/[^A-Za-z]/", ""), 0, 6)}-tg${substr(uuid(), 0, 3)}"
  tg_protocol                 = "HTTP"
  vpc_ids                     = var.vpc_id
  application_port            = var.application.port
  health_check_path           = var.application.health_check_path
}

data "aws_lb" "apps_load_balancer" {
  name = var.alb_name
}

data "aws_lb_listener" "http_listener" {
  load_balancer_arn = data.aws_lb.apps_load_balancer.arn
  port              = 80

  depends_on = [data.aws_lb.apps_load_balancer]
}


module "application_http_listener" {
  source                  = "../../resources/lb-listener-rule-path-pattern"
  environment             = var.environment
  listener_arn            = data.aws_lb_listener.http_listener.arn
  target_group_arn        = module.application_target_group.target_group_arn
  listener_condition_path = "${var.application.context}/*"

  depends_on = [
    data.aws_lb_listener.http_listener,
    module.application_target_group,
  ]
}

data "aws_iam_role" "task_role" {
  name = var.application.task_role_name
}

data "aws_iam_role" "execution_role" {
  name = var.application.execution_role_name
}

module "application_task_definition" {
  source                          = "../../resources/ecs-task-definition"
  family                          = var.application.name
  execution_role_arn              = data.aws_iam_role.execution_role.arn
  task_role_arn                   = data.aws_iam_role.task_role.arn
  network_mode                    = "bridge"
  requires_compatibilities        = ["EC2"]
  container_environment_variables = var.application.environment_variables
  container_image                 = "${var.account}.dkr.ecr.${var.region}.amazonaws.com/${var.application.ecr}:${var.image_version}"
  container_log_group             = module.application_logs.log_group_name
  container_log_region            = var.region
  container_memory_reservation    = 512
  container_name                  = var.application.name
  container_port                  = var.application.port
  container_port_protocol         = "tcp"
  environment                     = var.environment
  application                     = var.application.name

  depends_on = [
    module.application_logs,
    data.aws_iam_role.execution_role,
    data.aws_iam_role.task_role
  ]
}

data "aws_ecs_cluster" "cluster" {
  cluster_name = var.cluster_name
}


module "application_ecs_service" {
  source                = "../../resources/ecs-service"
  service_name          = var.application.name
  cluster_id            = data.aws_ecs_cluster.cluster.id
  task_definition_arn   = module.application_task_definition.arn
  desired_count         = 1

  application           = var.application.name
  environment           = var.environment

  load_balancer         = [{
    target_group_arn  = module.application_target_group.target_group_arn
    container_name    = var.application.name
    container_port    = var.application.port
  }]

  capacity_providers = var.application.providers

  depends_on = [
    data.aws_ecs_cluster.cluster,
    module.application_task_definition,
    module.application_target_group
  ]
}