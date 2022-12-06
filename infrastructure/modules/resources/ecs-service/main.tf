resource "aws_ecs_service" "ecs_service" {
  name                = var.service_name
  cluster             = var.cluster_id
  task_definition     = var.task_definition_arn
  desired_count       = var.desired_count
  iam_role            = var.service_role_arn
  scheduling_strategy = var.scheduling_strategy

  dynamic "load_balancer" {
    for_each = var.load_balancer

    content {
      target_group_arn = load_balancer.value["target_group_arn"]
      container_name   = load_balancer.value["container_name"]
      container_port   = load_balancer.value["container_port"]
    }
  }

  dynamic "deployment_circuit_breaker" {
    for_each = var.deployment_circuit_breaker_enabled ? toset([var.deployment_circuit_breaker_rollback]) : toset([])

    content {
      enable   = var.deployment_circuit_breaker_enabled
      rollback = deployment_circuit_breaker.value
    }
  }

  dynamic "deployment_controller" {
    for_each = var.deployment_controller_enabled ? toset([var.deployment_controller_type]) : toset([])

    content {
      type = deployment_controller.value
    }
  }

  dynamic "capacity_provider_strategy" {
    for_each = var.capacity_providers
    iterator = item

    content {
      capacity_provider = item.value["capacity_provider"]
      weight = item.value["weight"]
    }
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = {
    Environment = var.environment
    Application = var.application
  }
}