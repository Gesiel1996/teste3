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
    cidr_blocks = ["10.86.49.128/25","10.0.0.0/16","10.0.0.0/8"]

  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    description = "SSH"
    cidr_blocks = ["10.0.0.0/16","10.0.0.0/8"]
  },
  {
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    description = "RDP"
    cidr_blocks = ["10.86.49.128/25","10.0.0.0/8"]
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


   sg_name = "ec2-projeto-infra-ccc"
    vpc_id: "vpc-0bc6ff2448d3c3ed7"
  
 

}

