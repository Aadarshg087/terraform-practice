variable "instances" {
  type = map(object({
    instance_type = string
    volume        = number
    name          = string
    purpose       = string
  }))
}

