resource "aws_security_group" "main" {
  name                   = var.sg_name
  description            = var.sg_name
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = false

  dynamic "ingress" {
    for_each = var.ingress_config
    content {
      from_port   = lookup(ingress.value, "from_port", 0)
      to_port     = lookup(ingress.value, "to_port", 0)
      protocol    = lookup(ingress.value, "protocol", "-1")
      description = lookup(ingress.value, "description", "All")
      cidr_blocks = lookup(ingress.value, "cidr_blocks", ["0.0.0.0/0"])
    }
  }

  dynamic "egress" {
    for_each = var.egress_config
    content {
      from_port   = lookup(egress.value, "from_port", 0)
      to_port     = lookup(egress.value, "to_port", 0)
      protocol    = lookup(egress.value, "protocol", "-1")
      description = lookup(egress.value, "description", "All")
      cidr_blocks = lookup(egress.value, "cidr_blocks", ["0.0.0.0/0"])
    }
  }

  tags = var.tags
}
