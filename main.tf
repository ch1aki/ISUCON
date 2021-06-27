provider "aws" {
  region = "ap-northeast-1"
}

module "aws_isucon_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "aws-isucon"
  description = "aws-isucon"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  egress_rules        = ["all-all"]
}

resource "aws_instance" "isucon10" {
  ami           = "ami-03bbe60df80bdccc0" # isucon10-qualify
  instance_type = "t2.small"
  key_name      = "isucon"

  vpc_security_group_ids = [module.aws_isucon_sg.security_group_id]

  root_block_device {
    volume_type = "gp2"
    volume_size = 50
  }

  tags = {
    Name = "ISUCON10"
  }
}

