# Variables
# Some sensitive information
 variable "v-access-key" {}
 variable "v-secret-key" {}
 variable "region" {}

# Shareable information
variable "v-ami-image" {
    description = "Amazon Linux 2023 AMI"
    default = "ami-0fa03365cde71e0ab"
}
variable "v-instance-type" {
    description = "EC2 instance type"
    default = "t2.micro"
}
variable "v-instance-key" {
    description = "Instance key"
    default = "terraform-key2"
}

variable "v_vsgi" {}
variable "v_si" {}
