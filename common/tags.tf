variable "common_tags" {
  description = "common tags to be applied to all resources" 
  type = map(string)
  default = {    
    core-app-owner        = var.core_app_owner
    core-data-owner       = var.core_data_owner
    core-tech-owner       = var.core_tech_owner
    core-application-name = var.project_stack_name
    core-env              = var.environment
    core-bap-number       = var.core_bap_number
    core-cost-center      = var.core_cost_center
    cost_center = var.cost_center
    managed_by = "terraform"
  }
}



output "common_tags" {
  value = var.common_tags
}