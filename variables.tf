locals {
  name_prefix  = "lj"
  region_short = "uks"
  region_long  = "uksouth"
  environment  = "dev"
}

variable "public_ip" {
  description = "Public IP address to allow access to the storage account"
  type        = string
  default     = ""
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  default     = ""
  type        = string
}

variable "admin_password" {
  description = "Admin password for the virtual machine"
  default     = ""
  type        = string
}
