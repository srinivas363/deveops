data "availability_zones" "az" {
}
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "pubsns" {
  count=length(data.aws_availability_zones.az.names)
  availability_zones=element(data.aws_availability_zones.az.names,count.index)
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = element("10.0.0.0/16",8,count.index)
}
resource "aws_internet_gateway" "igw" {
  vpc_id     = aws_vpc.vpc1.id
  }
resource "aws_route_table" "rt1" {
  vpc_id     = aws_vpc.vpc1.id
  route{
    cidr_block="0.0.0.0/0"
	gateway_id= aws_internet_gateway.igw
	}
}
