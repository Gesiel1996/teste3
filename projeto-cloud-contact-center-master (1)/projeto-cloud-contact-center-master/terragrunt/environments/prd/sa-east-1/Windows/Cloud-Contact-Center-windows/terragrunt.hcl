
include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../../modules//ec2"
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
env = "prd"
tag_name = "Cloud-Contact-Center-Windows-Prd"
ami_id = ""
public_ip_address = false
instances = [
  {
    aws_zone = "sa-east-1a"
    aws_subnet = ""
    root_block_size = "300"
    instance_size = "t3a.2xlarge"
    private_ip = ["10.86.48.33"]
  },
  {
    aws_zone = "sa-east-1a"
    aws_subnet = ""
    root_block_size = "300"
    instance_size = "t3a.2xlarge"
    private_ip = ["10.86.48.33"]
  }
]
tags = {
 ef_iac             = "terraform"    
 ef_projeto         = "Projeto-Infrac-call-center"    
 ef_provedor        = "aws"    
 ef_produto         = "infraestrutura"    
 ef_plataforma      = "Projeto-Infrac-call-center"    
 ef_shared          = "nao"    
 ef_backup          = "sem_backup"    
 ef_torre           = "TI"    
 ef_centro_de_custo = "TI"    
 ef_recuperacao_de_desastre  = "nao"    
 ef_departamento      = "TI"    
 ef_regiao            = "sa-east-1"    
 ef_ambiente          = "prd"    
 Name                 = "Cloud-Contact-Center-Windows"
}  

security_groups = [""]


volume_type = "gp3"
delete_termination = true
key_pair_name = ""

}