variable cluster_name {
  type        = string
  description = "Nome do cluster, sem espaços."
}

variable custom_log_group {
  type        = list
  default     = []
  description = "(Optional) Log Group para o cluster. Essa informação só será considerada caso a custom_log_enabled seja true"
}

variable "tags" {
  type = map
  default = {}
  description = "(Optional) Map of tags assigned to the cluster"
}

variable "propagate_tags" {
  type = map
  default = {}
  description = "(Optional) Map of tags assigned to the resource, including those inherited from the provider"
}

variable "capacity_providers" {
  type = list
  default = []
  description = "(Optional) List of capacity providers to cluster"
}

variable "default_capacity_providers" {
  type = list
  default = []
  description = "(Optional) List of capacity providers to use them in cluster default"
}
