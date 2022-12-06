variable listener_arn {
  type = string
  description = "ARN do Listener onde será criado a regra"
}

variable priority {
  type  = number
  default = null
  description = "Número de prioridade da regra entre as demais regras do balanceador. Varia de 1 até 1000"
}

variable listener_condition_path {
  type = string
  description = "Path Pattern que será utilizado como condição dentro da regra do balanceador"
}

variable target_group_arn {
  type        = string
  description = "(Optional) The ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead."
}

variable "environment" {
  type = string
  description = "Environment Name (Tag)"
}