resource "aws_instance" "new_sosoec2_instance" {
  # (resource arguments)
}

# go yo your ec2 UI and collect the instance ID you intend to import
# in thie example, my instance ID is i-0cfe56fa519420ca5
# add the above code to a new file called import.tf and run the below command

$ terraform import aws_instance.new_sosoec2_instance i-0cfe56fa519420ca5
# After import is successful, you can redifine your import.tf as such below...you can even de beyond

resource "aws_instance" "new_ec2_instance" {
  ami = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
}

