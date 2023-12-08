resource "aws_instance" "main" {
  count                       = length(var.instances)
  ami                         = var.ami_id
  associate_public_ip_address = var.public_ip_address
  availability_zone           = var.instances[count.index].aws_zone
  instance_type               = var.instances[count.index].instance_size
  vpc_security_group_ids      = var.security_groups
  subnet_id                   = var.instances[count.index].aws_subnet
  key_name                    = var.key_pair_name
  private_ip                  = var.instances[count.index].private_ip[0]
  iam_instance_profile        = aws_iam_instance_profile.ssm_profile.name



  depends_on = [aws_iam_role.ssm_role, aws_iam_instance_profile.ssm_profile]




  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.instances[count.index].root_block_size
    delete_on_termination = var.delete_termination
  }
  tags = var.tags
}

resource "aws_iam_role" "ssm_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}
resource "aws_iam_instance_profile" "ssm_profile" {
  role       = aws_iam_role.ssm_role.id
  depends_on = [aws_iam_role.ssm_role]
}

resource "aws_iam_policy" "policy" {
  description = "Generated by terraform"
  policy      = var.custom_policy
}

resource "aws_iam_role_policy_attachment" "ssm_ec2_role" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  depends_on = [aws_iam_role.ssm_role]
}

resource "aws_iam_policy_attachment" "ec2-policy-attachment" {
  name       = "ec2-policy"
  roles      = [aws_iam_role.ssm_role.name]
  policy_arn = aws_iam_policy.policy.arn
  depends_on = [aws_iam_role.ssm_role, aws_iam_policy.policy]
}