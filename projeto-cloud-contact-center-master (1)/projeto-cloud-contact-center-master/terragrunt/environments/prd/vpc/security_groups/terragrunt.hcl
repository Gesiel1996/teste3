include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../modules/security_group"
}


generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
    provider "aws" {
    region = "sa-east-1"
}
EOF
}

inputs = {
  ingress_config = [
    {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    description = "SSH"
    cidr_blocks = ["10.86.48.0/24"]
  }, 
  {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    description = "HTTPS"
    cidr_blocks = ["10.86.48.0/24"]
  },
  {
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    description = "RDP"
    cidr_blocks = ["10.86.48.0/24"]
  }
]

  egress_config = [
    {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "ALL"
    cidr_blocks = ["0.0.0.0/0"]
    }
  ]


  sg_name = "ec2-projeto-infra-contact-center"
  vpc_id: "vpc-0d86caaacb8f673b1"
 

}

