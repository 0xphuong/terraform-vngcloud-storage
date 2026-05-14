variable "project_id" {
  description = "VNG Cloud project ID"
  type        = string
}

variable "volumes" {
  description = "Shared volume parameters and per-volume configurations"
  type = object({
    volume_type_id = string
    zone_id        = optional(string)
    volume_configs = map(object({
      count     = number
      size      = number
      server_id = optional(string, null)
      zone_id   = optional(string)
    }))
  })

  validation {
    condition     = alltrue([for k, v in var.volumes.volume_configs : v.count >= 1])
    error_message = "Each volume_config must have count >= 1."
  }
  validation {
    condition     = alltrue([for k, v in var.volumes.volume_configs : v.size >= 2])
    error_message = "Volume size must be at least 2 GB."
  }
}
