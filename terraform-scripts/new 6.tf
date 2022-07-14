resource "aws_ebs_volume" "v1" {
  count=3
  availability_zone = "ap-south-1a"
  size              = 10

  tags = {
    Name = "HelloWorld"
  }
}
output "vids"{
value=aws_ebs_volume.v1.id
}
output "vid_1"{
value=aws_ebs_volume.v1.*.id[0]
}
output "vid_2"{
value=aws_ebs_volume.v1.*.id[1]
}
output "vid_3"{
value=aws_ebs_volume.v1.*.arn[3]
}