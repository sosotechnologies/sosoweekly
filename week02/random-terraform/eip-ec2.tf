provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "soso-eip-instance" {
    ami = "ami-0b0dcb5067f052a63"
    instance_type = "t2.micro"
}

resource "aws_eip" "elasticeip" {
    instance = aws_instance.soso-eip-instance.id
}

output "EIP" {
    value = aws_eip.elasticeip.public_ip
}
