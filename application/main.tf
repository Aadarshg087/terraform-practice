resource "aws_instance" "ec2-application" {
  for_each = var.instances
  ami      = "ami-0ecb62995f68bb549"

  instance_type = each.value.instance_type
  # volume        = each.value.volume



  # user_data = <<-EOF
  #   #!/bin/bash
  #   set -e

  #   # Update system
  #   sudo apt update -y

  #   # Install Node.js LTS (via NodeSource)
  #   curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  #   sudo apt install -y nodejs

  #   # Verify installation
  #   node -v
  #   npm -v

  #   git clone https://github.com/Aadarshg087/BookVault.git
  #   cd Backend
  #   sudo apt install -y docker.io
  #   sudo docker build . -t backend3
  #   sudo docker run -d -p 3000:3000 backend3

  # EOF

  vpc_security_group_ids = [aws_security_group.allow_comm.id]

  tags = {
    Purpose     = each.value.purpose
    Environment = "dev"
    Name        = each.value.name
  }
}

data "aws_vpc" "default" {
  default = true
}


resource "aws_security_group" "allow_comm" {
  name        = "Allow-Communication"
  description = "Allowing the communication from outside"
  vpc_id      = data.aws_vpc.default.id
  tags = {
    Purpose     = "Learning"
    Environment = "Dev"
  }
}

# resource "aws_vpc_security_group_ingress_rule" "allow_incoming" {
#   security_group_id = aws_security_group.allow_comm.id
#   cidr_ipv4         = "0.0.0.0/0"
#   #   cidr_ipv4         = data.aws_vpc.default.cidr_block
#   from_port   = 3000
#   ip_protocol = "tcp"
#   to_port     = 3000
# }



resource "aws_vpc_security_group_ingress_rule" "ssh_connect" {
  security_group_id = aws_security_group.allow_comm.id
  cidr_ipv4         = "0.0.0.0/0"
  #   cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}


# resource "aws_vpc_security_group_egress_rule" "allow_outgoing" {
#   security_group_id = aws_security_group.allow_comm.id
#   cidr_ipv4         = "0.0.0.0/0"
#   #   cidr_ipv4         = data.aws_vpc.default.cidr_block
#   from_port   = -1
#   ip_protocol = "-1"
#   to_port     = -1
# }

