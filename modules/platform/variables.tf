# modules/platform/variables.tf
variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "storage_account_suffix" {
  description = "Suffix for storage account name"
  type        = string
  default     = "st"
}

variable "eventhub_partition_count" {
  description = "Number of event hub partitions"
  type        = number
  default     = 2
}