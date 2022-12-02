provider "aws" {
	region = var.aws_region
}

module "my_instance_module" {
        source = "../../../../modules/ec2"
        ami = "ami-0b0dcb5067f052a63"
        instance_type = "t2.micro"
        instance_name = "soso-instance"
}