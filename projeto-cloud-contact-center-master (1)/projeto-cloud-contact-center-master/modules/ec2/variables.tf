variable "ami_id" {
  default = ""
  type    = string
}
variable "public_ip_address" {
  type    = bool
  default = false

}

variable "security_groups" {
  type    = list(string)
  default = []

}
variable "tags" {
  type = map(string)
  default = {

  }
}

variable "instance_size" {
  default = ""
}


variable "tag_name" {
  default = ""
  type    = string
}


variable "volume_type" {
  type    = string
  default = ""

}
variable "delete_termination" {
  type    = bool
  default = false

}

variable "key_pair_name" {
  type    = string
  default = ""
}


variable "aws_region" {
  type        = string
  description = ""
  default     = ""
}
variable "instances" {
  description = "Instances Config"
  type = list(object({

    aws_zone        = string
    aws_subnet      = string
    root_block_size = string
    instance_size   = string
    private_ip      = list(string)

  }))
  default = []
}

variable "iam_instance_profile" {
  description = "Instance Profile do IAM vinculado à instância"
  default     = ""
}
variable "aws_iam_role" {
  default = ""

}
variable "custom_policy" {
  type        = string
  description = "Policy to be attached to the EC2 instance"
  default     = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*",
        "s3:List*",
        "ssm:GetParameters",
        "ssm:GetParameter"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
POLICY
}
variable "enable_ssm" {
  description = "Habilita o AWS SSM Session Manager. Essa é uma forma mais segura de conexão à instância do que a conexão por SSH"
  default     = true
}