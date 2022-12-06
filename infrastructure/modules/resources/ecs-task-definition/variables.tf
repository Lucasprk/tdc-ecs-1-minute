variable "family" {
  type        = string
  description = "A unique name for your task definition."
}

variable "execution_role_arn" {
  type        = string
  default     = ""
  description = "(Optional) ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume"
}

variable "task_role_arn" {
  type        = string
  default     = ""
  description = "ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services."
}

variable "network_mode" {
  type        = string
  default     = "bridge"
  description = "(Optional) Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host"
}

variable "requires_compatibilities" {
  type        = list
  default     = ["EC2, FARGATE"]
  description = "(Optional) Set of launch types required by the task. The valid values are EC2 and FARGATE"
}

variable "container_environment_variables" {
  type        = list
  default     = []
  description = "Environment variables to set in container start"
}

variable "container_image" {
  type        = string
  description = "ECR Url to container image"
}

variable "container_log_group" {
  type        = string
  description = "A valid log group name to container logs"
}

variable "container_log_region" {
  type        = string
  description = "The region of container log group"
}

variable "container_memory_reservation" {
  type        = number
  description = "The memory reservation (in MB) for container (Soft Limit)"
}

variable "container_name" {
  type        = string
  description = "The container name. This name NOT conflict with the task definition name."
}

variable "container_port" {
  type        = number
  description = "The container port to start application"
}

variable "host_port" {
  type        = number
  default     = 0
  description = "The host port. If you use a Load Balancer please don't use this property"
}

variable "container_port_protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol to use in container port"
}

variable "environment" {
  type        = string
  description = "Environment (such as prod, qa, dev)"
}

variable "application" {
  type        = string
  description = "Application related to this resource"
}