variable "service_name" {
  type = string
  description = "Nome do Serviço no ECS"
}

variable "cluster_id" {
  type = string
  description = "Nome do Cluster onde o serviço será criado"
}

variable "task_definition_arn" {
  type = string
  description = "ARN da Task Definition"
}

variable "desired_count" {
  type = number
  default = 1
  description = "Quantidade de tarefas que o serviço vai manter sempre no ar"
}

variable "service_role_arn" {
  type = string
  default = ""
  description = "ARN da role que será concedida ao serviço"
}

variable "scheduling_strategy" {
  type = string
  default = "REPLICA"
  description = "Estratégia de scheduling do serviço. Se for REPLICA, o número de tarefas de pé vai ser de acordo com o desired count. Se for DAEMON, toda instância do cluster terá uma tarefa deste serviço"
}

variable "load_balancer" {
  type = list
  default = []
  description = "Lista com apenas um elemento informando as informações do load balancer. Opcional"
}

variable "deployment_circuit_breaker_enabled" {
  type = bool
  default = false
  description = "(Optional) Whether to enable the deployment circuit breaker logic for the service."
}

variable "deployment_circuit_breaker_rollback" {
  type = bool
  default = false
  description = "(Optional) Whether to enable Amazon ECS to roll back the service if a service deployment fails. If rollback is enabled, when a service deployment fails, the service is rolled back to the last deployment that completed successfully."
}

variable "deployment_controller_enabled" {
  type = bool
  default = false
  description = "(Optional) Enable deployment controller configuration block"
}

variable "deployment_controller_type" {
  type = string
  default = "ECS"
  description = "(Optional) Type of deployment controller. Valid values: CODE_DEPLOY, ECS, EXTERNAL. Default: ECS."
}

variable "capacity_providers" {
  type = list
  default = []
  description = "(Optional) Capacity provider strategy to use for the service. Can be one or more. Detailed below."
}

variable "environment" {
  type = string
  description = "Environment (such as prod, qa, dev)"
}

variable "application" {
  type = string
  description = "Application related to this resource"
}