variable "v_size"{
  type=list
  default=[5,6,7]
  }
resource "aws_ebs_volume" "v1" {
  count=3
  availability_zone = "ap-south-1a"
  size              = var.v_size[count.index]

  tags = {
    Name = "HelloWorld"
  }
}
