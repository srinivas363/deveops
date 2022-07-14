variable "env"{
  type=string
 }
resource "aws_instance" "i1" {
  ami           = "ami-01178266459059e8a"
  instance_type = "t2.micro"
  tags = {
    Name = "HelloWorld"
  }
}
resource "aws_eip" "eip" {
  count=var.env=="prod"?1:0
  instance = aws_instance.i1.id
  vpc      = true
}

