resource "aws_key_pair" "ec2_key_sis" {
  key_name   = "ec2_key_sis"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDylxhkBYhYyhbWk2J9dJelN8WY6nzm1MenGZqXy3/YzEM1Kl/sGVPeX0YuLx1YkE1sM9hKhYv3M5KB4P2M8Y5D6wLP3o/hEDXcxH+TVpvke95gRftxEPGZ6TzDZRWLu0ROjT3btDxW58Bnsr1xZU9Zn1KenqiaCw20kYhOewe3D7QQkpbZzHuA1ZlOi8yIPjM3yCte52jdFEAiVwa/rqvBDnVRWryN6lZQmlpYRJRoiMKApzfV9nieeJHjnXJLUzSDp2DNkej4D40r+y/0RQXGw/gRDR4CobUnJlWK2wD0AaMgPLHIgwb3ltUM6dPnXEcU78eWizTe11p0vI1qqgD/ vini@vinicius"
}

resource "aws_instance" "ec2_sis" {
  ami                    = "ami-0b0b78dcacbab728f"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ec2_key_sis.id
  vpc_security_group_ids = [aws_security_group.sg_sis.id]
  iam_instance_profile = "ec2-role"

  tags = {
    Name        = "ec2_sis"
    Provisioned = "Terraform"
  }
}



resource "aws_security_group" "sg_sis" {
  name   = "sg_sis"
  vpc_id = "vpc-0f116211a7b3bc6aa"

  tags = {
    Name = "sg_sis"
    Provisioned : "Terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg_sis.id
  # cidr_ipv4         = "189.46.98.196/32"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.sg_sis.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.sg_sis.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg_sis.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}