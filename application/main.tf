resource "aws_instance" "ec2-application" {
  ami = "ami-0ecb62995f68bb549"

  instance_type = "t3.micro"
  tags = {
    Purpose     = "Learning"
    Environment = "dev"
    Name        = "application-nonprod"
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

resource "aws_vpc_security_group_ingress_rule" "allow_incoming" {
  security_group_id = aws_security_group.allow_comm.id
  cidr_ipv4         = "0.0.0.0/0"
  #   cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port   = 8000
  ip_protocol = "tcp"
  to_port     = 8000
}


resource "aws_vpc_security_group_egress_rule" "allow_outgoing" {
  security_group_id = aws_security_group.allow_comm.id
  cidr_ipv4         = "0.0.0.0/0"
  #   cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port   = -1
  ip_protocol = "-1"
  to_port     = -1
}

