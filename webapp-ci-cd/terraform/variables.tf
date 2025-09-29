
variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  type = string
  description = "AWS key pair for SSH access"
}

variable "region" {
  default = "eu-north-1"
}

