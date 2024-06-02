variable "project_name" {
  description = "The name of the project."
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

variable "team_tags" {
  description = "Specific tags for the team."
  type        = map(string)
  default     = {}
}