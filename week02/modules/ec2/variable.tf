variable "ami" {
  type          = string
  default       = "ami-0b0dcb5067f052a63"
}

variable "instance_type" {
  type          = string
  default       = "t2-micro"
}

variable "instance_name" {
  description   = "Value of the Name tag for the EC2 instance"
  type          = string
  default       = "sosotech_instance"
}

variable "key_name" {
  type          = string
  default       = "soso-master-key"
}