variable "account" {
  type        = string
  description = "The Account ID Number"
}

variable "region" {
  type        = string
  description = "Amazon Region such as us-east-1"
}

variable "environment" {
  type        = string
  description = "The environment name such as qa or prod"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the application will be available"
}

variable "alb_name" {
  type        = string
  description = "The name of Application Load Balancer to use in application"
}

variable "cluster_name" {
  type        = string
  description = "Cluster where application will be deployed"
}

variable "image_version" {
  type        = string
  description = "The tag of docker image to use in service"
}

variable "application" {
  type = object({
    name                  = string
    port                  = number
    log_retention_days    = number
    context               = string
    health_check_path     = string
    environment_variables = list(map(any))
    execution_role_name   = string
    task_role_name        = string
    ecr                   = string
    providers             = list(object({
      capacity_provider = string
      weight = number
    }))
  })
}