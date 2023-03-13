variable "jogday_tags" {
  description = "Tags for resource tracking"
  type = object({
    name       = string
    created-by = string
  })
  default = {
    name       = "jogday"
    created-by = "LPB"
  }
}

variable "region" {
  type        = string
  description = "Jogday region"
  default     = "ap-southeast-2"
}
