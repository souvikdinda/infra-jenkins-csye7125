# Creating key pair to enable ssh connection to ec2 instance

data "aws_key_pair" "ec2" {
  key_name = "ec2"
}


# Creating  EC2 Instance
resource "aws_instance" "jenkins_instance" {
  ami                     = data.aws_ami.jenkins-ami.id
  instance_type           = var.configuration.ec2_instance.instance_type
  disable_api_termination = "false"
  root_block_device {
    volume_size           = var.configuration.ec2_instance.volume_size
    volume_type           = var.configuration.ec2_instance.volume_type
    delete_on_termination = true
  }
  subnet_id                   = aws_subnet.public-subnets.id
  security_groups             = ["${aws_security_group.jenkins_security_group.id}"]
  key_name                    = data.aws_key_pair.ec2.key_name
  associate_public_ip_address = true
  tags = {
    "Name" = "Jenkins Server"
  }

  user_data_base64 = base64encode(join("\n", [
    "#!/bin/bash",
    "sudo sed -i 's/:80 {/jenkins.${var.host_name} {/g' /etc/caddy/Caddyfile",
    "sudo sed -i '/reverse_proxy localhost:8080/a\\ \\ \\ \\ tls ${var.email}' /etc/caddy/Caddyfile",
    "sudo systemctl restart caddy"
  ]))

}

# Attaching Elastic IP to EC2
resource "aws_eip_association" "eip_association" {
  instance_id   = aws_instance.jenkins_instance.id
  allocation_id = data.aws_eip.elastic_ip.id
}


