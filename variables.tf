variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "publicroutetablecidr" {
  default = "0.0.0.0/0"
}

variable "region" {
  default = "us-east-1"
}

# variable "profile" {
#   default = "devprofile"
# }

# Declare the data source
data "aws_availability_zones" "available_zones" {
  state = "available"
}

variable "ami" {
  default = "ami-08e025ab87d09e589"

}

variable "ami_owner" {
  default = "031552419504"

}

variable "zone_name" {
  default = "jenkins.dev.vaishnavipuppala.me"
}


variable "domain" {
  default     = "dev.vaishnavipuppala.me"
}

variable "zone_id" {
  default     = "Z10190692SDJV7WK1Z9Y8"
}