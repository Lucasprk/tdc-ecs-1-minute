variable role_name {
  type        = string
  description = "Nome da Role"
}

variable role_description {
  type        = string
  default     = null
  description = "Descrição da role"
}


variable assume_role_policy {
  type        = string
  description = "Politica principal da role. Deve ser informado o formato em json"
}

variable managed_policy_arn_list {
  type        = list
  default     = []
  description = "Lista de ARNs das politicas associadas a esta role. Não obrigatório"
}