variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "region" {
  default = "us-east-1"
}

data "aws_availability_zones" "available_zones" {
  state = "available"
}

variable "publicroutetablecidr" {
  default = "0.0.0.0/0"
}

data "aws_ami" "jenkins-ami" {
  most_recent = true
  owners      = ["191434387957"]

  filter {
    name   = "name"
    values = ["JenkinsAMI_*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "configuration" {
  description = "Configuration Settings"
  type        = map(any)
  default = {
    "ec2_instance" = {
      instance_type = "t2.micro"
      volume_size   = 50
      volume_type   = "gp2"
    }
  }
}

variable "host_name" {
  type    = string
  default = "souvikdinda.me"
}

variable "email" {
  type    = string
  default = "dinda.s@northeastern.edu"
}

data "aws_route53_zone" "zone_name" {
  name = var.host_name
}

data "aws_eip" "elastic_ip" {
  filter {
    name   = "tag:Name"
    values = ["JenkinsElasticIP"]
  }
}