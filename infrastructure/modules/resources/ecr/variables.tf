variable "repo_name" {
  type = string
  description = "(Required) Name of the repository."
}

variable "max_images" {
  type = number
  description = "The number of maximum images to keep in repository"
}

variable "application" {
  type = string
  description = "Application Name (Tag)"
}

variable "environment" {
  type = string
  description = "Environment Name (Tag)"
}