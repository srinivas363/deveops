variable "env"{
  type=string
 }
resource "aws_instance" "i1" {
  ami           = "ami-01178266459059e8a"
  instance_type =var.env=="dev"?"t2.micro":var.env=="test"?"t2.small":"t2.large"
  tags = {
    Name = "HelloWorld"
}
}