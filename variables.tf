variable "location" {
  description = "Azure region"
  type        = string
  default     = "brazilsouth"
}

variable "prefix" {
  description = "Prefix used for resource names"
  type        = string
  default     = "techfusion"
}

variable "environment" {
  description = "Environment tag (dev/staging/prod)"
  type        = string
  default     = "dev"
}

variable "admin_username" {
  description = "Admin username for VMSS"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "vm_size" {
  description = "VM size for VMSS"
  type        = string
  default     = "Standard_B1ms"
}

variable "instance_count" {
  description = "Initial VMSS instance count"
  type        = number
  default     = 1
}

variable "office_ip_cidr" {
  description = "Your office public IP in CIDR format to allow SSH access (e.g. 1.2.3.4/32)"
  type        = string
  default     = "YOUR_OFFICE_IP/32"
}

variable "eventhub_partition_count" {
  type    = number
  default = 4
}

variable "cosmos_offer_tier" {
  type    = string
  default = "Standard"
}

variable "storage_account_suffix" {
  description = "Suffix for storage account (must be unique globally, lowercase, no hyphens)."
  type        = string
  default     = "tfstorage12345"
}
