resource "aws_ecs_cluster" "ecs_cluster" {
  name                = var.cluster_name
  tags_all            = var.propagate_tags
  tags                = var.tags
  capacity_providers  = var.capacity_providers

  dynamic "configuration" {
    for_each = var.custom_log_group

    content {
      execute_command_configuration {
        logging = "OVERRIDE"

        log_configuration {
          cloud_watch_encryption_enabled = false
          cloud_watch_log_group_name     = configuration.value["log_group_name"]
        }
      }
    }
  }

  dynamic "default_capacity_provider_strategy" {
    for_each = var.default_capacity_providers
    iterator = capacity_provider
    content {
      capacity_provider = capacity_provider.value
    }
  }
}