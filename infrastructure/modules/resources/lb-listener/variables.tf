variable alb_arn {
  type        = string
  description = "ARN do Load Balancer"
}

variable port {
  type        = string
  description = "Porta onde será criado o listener no Load Balancer"
}

variable protocol {
  type        = string
  description = "Protocolo de comunicação do listener"
}

variable target_group_arn {
  type        = string
  description = "ARN do Target Group Default"
}

variable environment {
  type        = string
  description = "Nome do ambiente."
}