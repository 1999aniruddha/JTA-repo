variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "AWS key pair name (must exist in the region)"
}

variable "region" {
  default = "eu-north-1"
}
