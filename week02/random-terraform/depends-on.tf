provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "soso-db-instance" {
    ami = "ami-0b0dcb5067f052a63"
    instance_type = "t2.micro"
}

resource "aws_instance" "soso-web-instance" {
    ami = "ami-0b0dcb5067f052a63"
    instance_type = "t2.micro"

    depends_on = [aws_instance.soso-db-instance]
}
