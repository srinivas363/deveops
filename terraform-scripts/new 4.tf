variable "env"{
  type=string
 }
resource "aws_instance" "i1" {
  ami           = "ami-01178266459059e8a"
  instance_type =var.env=="dev"?"t2.micro":t2.small"
  tags = {
    Name = "HelloWorld"
}
}