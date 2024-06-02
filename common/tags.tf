variable "core_app_owner" {
  description = "Core app owner"
  type        = string
}

variable "core_data_owner" {
  description = "Core data owner"
  type        = string
}

variable "core_tech_owner" {
  description = "Core tech owner"
  type        = string
}

variable "project_stack_name" {
  description = "Project stack name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "core_bap_number" {
  description = "Core BAP number"
  type        = string
}

variable "core_cost_center" {
  description = "Core cost center"
  type        = string
}

variable "cost_center" {
  description = "Cost center"
  type        = string
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {
    core-app-owner        = var.core_app_owner
    core-data-owner       = var.core_data_owner
    core-tech-owner       = var.core_tech_owner
    core-application-name = var.project_stack_name
    core-env              = var.environment
    core-bap-number       = var.core_bap_number
    core-cost-center      = var.core_cost_center
    cost_center           = var.cost_center
    managed_by            = "terraform"
  }
}

output "common_tags" {
  value = var.common_tags
}
