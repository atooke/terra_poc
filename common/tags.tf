variable "tags" {
  type = map(string)
  default = {
    project     = var.project_name
    cost_center = var.cost_center
    owner       = var.owner
  }
}

output "tags" {
  value = var.tags
}