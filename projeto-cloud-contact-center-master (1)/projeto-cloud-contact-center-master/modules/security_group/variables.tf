variable "ingress_config" {
  description = "Ingress config"
  type = list(object({
    from_port   = string
    to_port     = string
    protocol    = string
    description = string
    cidr_blocks = list(string)
  }))
  default = null
}

variable "egress_config" {
  description = "Egress config"
  type = list(object({
    from_port   = string
    to_port     = string
    protocol    = string
    description = string
    cidr_blocks = list(string)
  }))
  default = null
}

variable "tags" {
  description = "Map de tags para aplicar a recursos"
  type        = map(string)
  default     = {}
}

variable "sg_name" {
  type = string
  default = ""
}

variable "vpc_id" {
  type = string
  default = ""
}

