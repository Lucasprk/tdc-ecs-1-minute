locals {
  environment = {
    container_name = {
      name  = "APP_CONTAINER_NAME"
      value = var.container_name
    }
    container_port = {
      name  = "APP_PORT"
      value = var.container_port
    }
  }
}

// Container definitions
locals {
  containers = {
    app = {
      name              = var.container_name
      cpu               = 0
      environment       = var.container_environment_variables
      essential         = true
      image             = var.container_image
      command           = []
      logConfiguration  = {
        logDriver = "awslogs"
        options   = {
          awslogs-group         = var.container_log_group
          awslogs-region        = var.container_log_region
        }
      }
      memoryReservation = var.container_memory_reservation
      mountPoints       = []
      portMappings      = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
          protocol      = var.container_port_protocol
        },
      ]
      volumesFrom       = []
      dependsOn         = []
      links             = []
    }
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.family
  execution_role_arn       = var.execution_role_arn
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  tags                     = {}
  tags_all                 = {}
  task_role_arn            = var.task_role_arn

  container_definitions    = jsonencode([local.containers.app])
}