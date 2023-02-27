variable "retention_period" {
  description = "Time (in seconds) that messages will remain in queue before being purged"
  type        = number
  default     = 86400
}

variable "jogday_queue_name" {
  type        = string
  description = "Jogday Main Queue name"
  default     = "JogDayQueue"
}

variable "jogday_dlq_queue_name" {
  type        = string
  description = "Jogday Dead Letter Queue name"
  default     = "DLQ"
}

variable "visibility_timeout" {
  description = "Time (in seconds) that consumers have to process a message before it becomes available again"
  type        = number
  default     = 60
}

variable "receive_count" {
  description = "The number of times that a message can be retrieved before being moved to the dead-letter queue"
  type        = number
  default     = 3
}

variable "receive_wait_time_seconds" {
  type        = number
  default     = 20
  description = "Time (in seconds) that messages will be received"
}
