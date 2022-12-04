provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ec2" {
    ami = "ami-0b0dcb5067f052a63"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.sosotech-sec-grp.name]   //associating the seq grps with the instance
}

resource "aws_security_group" "sosotech-sec-grp" {
    name = "Allow HTTPS"

    ingress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0", "10.0.0.0/32","10.0.0.0/16"]
    }
         
    egress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
