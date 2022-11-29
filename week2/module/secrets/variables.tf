# variables
variable "secret_name" {}
variable "secret_desc" {}
variable "kms_key_id" {
  default     = ""
}

variable "secret_string" {
  default     = ""
}

variable "manual_input" {
  default     = false
}