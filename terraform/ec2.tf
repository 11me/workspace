resource "aws_key_pair" "ssh_keys" {
  for_each   = fileset(path.module, "*.pub")
  key_name   = each.key
  public_key = file(each.value)
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


module "vps" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  ami                    = "ami-050096f31d010b533"
  instance_type          = "t3.medium"
  key_name               = "id_rsa.pub"
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = ["${aws_security_group.vps_sg.id}"]



  root_block_device = [
    {
      volume_size = 20
    }
  ]

  tags = {
    Terraform = "true"
  }
}

resource "aws_security_group" "vps_sg" {
  name_prefix = "vps_sg"
  description = "Security group for vps"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

