variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "cost_center" {
  description = "The cost center for the project."
  type        = string
}

variable "owner" {
  description = "The owner of the project."
  type        = string
}

variable "location" {
  description = "The location of the resource."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID."
  type        = string
}

variable "team_ad_group" {
  description = "The Azure AD group for the team."
  type        = string
}

variable "team_admin_ad_group" {
  description = "The Azure AD admin group for the team."
  type        = string
}

variable "vnet_id" {
  description = "The ID of the virtual network."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet."
  type        = string
}
