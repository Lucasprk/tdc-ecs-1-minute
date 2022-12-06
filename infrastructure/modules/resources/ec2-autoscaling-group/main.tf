resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = var.name
  desired_capacity          = var.desired_count
  min_size                  = var.min_size
  max_size                  = var.max_size
  capacity_rebalance        = var.is_capacity_rebalanced
  vpc_zone_identifier       = var.subnet_ids
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_period
  target_group_arns         = var.target_group_arns

  mixed_instances_policy {

    instances_distribution {
      on_demand_allocation_strategy             = var.on_demand_allocation_strategy
      on_demand_base_capacity                   = var.on_demand_capacity
      on_demand_percentage_above_base_capacity  = var.on_demand_above_base_capacity
      spot_allocation_strategy                  = var.spot_allocation_strategy
      spot_max_price                            = var.spot_max_price
    }

    launch_template {
      launch_template_specification {
        launch_template_id = var.launch_template_id
      }

      dynamic override {
        for_each = var.instances_type
        iterator = instance_type

        content {
          instance_type = instance_type.value
        }
      }
    }
  }

  tags = var.tags
}
