variable "base_tags" {
  type        = map(string)
  default = {
    POCEmail :  "soso@soso.com"
    Org : "SOSO"
    App : "macaz"
  }
}

variable "iam_username" {
  type        = string
  default = null
}

variable "iam_policy_arn" {
  type        = string
  default = null
}

  variable "env" {
  type        = string
  default     =  "development"
}
