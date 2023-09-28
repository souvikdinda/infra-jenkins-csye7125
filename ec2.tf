# Creating key pair to enable ssh connection to ec2 instance
resource "aws_key_pair" "ec2" {
  key_name   = "connection-key"
  public_key = file("~/.ssh/ec2.pub")
}

data "aws_ami" "my-ami" {
  most_recent = true
  owners      = ["031552419504"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Creating  EC2 Instance
resource "aws_instance" "jenkins_instance" {
  ami                     = var.ami
  instance_type           = "t2.micro"
  disable_api_termination = "false"
  root_block_device {
    volume_size           = 50
    volume_type           = "gp2"
    delete_on_termination = true
  }
  subnet_id                   = aws_subnet.public-subnets[0].id
  security_groups             = ["${aws_security_group.jenkins_security_group.id}"]
  key_name                    = aws_key_pair.ec2.key_name
  associate_public_ip_address = true
  tags = {
    "Name" = "Jenkins Server"
  }
}

data "aws_eip" "elastic_ip" {
  filter {
    name   = "tag:Name"
    values = ["exampleNameTagValue"]
  }
}

# Attaching Elastic IP to EC2
resource "aws_eip_association" "eip_association" {
  instance_id   = aws_instance.jenkins_instance.id
  allocation_id = aws_eip.elastic_ip.id
}

# user_data = <<-EOF
#               #!/bin/bash
#               # Install Caddy
#               curl https://getcaddy.com | bash -s personal

#               # Configure Caddyfile for Jenkins and Let's Encrypt
#               cat <<EOL > /etc/caddy/Caddyfile
#               ${var.subdomain}.${var.domain} {
#                 reverse_proxy localhost:8080
#                 tls {
#                   dns route53
#                 }
#               }
#               EOL

#               # Start Caddy
#               systemctl enable caddy
#               systemctl start caddy
#               EOF




