
variable "resource_group_name" {
  description = "Resource group name"
  default = "devrg"
}

variable "aks_cluster_name" {
  description = "Name of the AKS Cluster"
  default = "devaks"
  
}

variable "location" {
  description = "Azure Region"
  default = "UAE North"
}

variable "client_id" {
  description = "Azure AD Client ID"
}

variable "client_secret" {
  description = "Azure AD Client Secret"
}

variable "environment" {
  description = "Environment (e.g., dev, uat, prod)"
  default = "dev"
}
variable "owner" {
  description = "Resource group owner"
  default = "team1"
}

variable "zones" {
  description = "list of availability zones"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "servername" {
  description = "Postgress server name"
  default = "pg"
}

variable "admin_username" {
  description = "DB USername"
  default = "admin"
}

variable "admin_password" {
  description = "DB Password"  
}