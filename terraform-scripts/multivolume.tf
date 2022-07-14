resource "aws_ebs_volume" "vol" {
  availability_zone="ap-south-1a"
  size=4
  type="gp2"
  }
resource "aws_ebs_volume" "vol1" {
  provider="aws.sing"
  availability_zone="ap-southeast-1a"
  size=4
  type="gp2"
  }