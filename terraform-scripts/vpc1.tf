variable "v_azs"{
   default=["ap-south-1a","ap-south-1b"]
}
variable "vpc_cidr"{
   default= "10.0.0.0/16"
}
variable "vpc_pub_sn_cidr"{
   default=["10.0.0.0/24","10.0.1.0/24"]
}
variable "vpc_pvt_sn_cidr"{
   default=["10.0.2.0/24","10.0.3.0/24"]
}
resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc_cidr
  tags= {
  Name="vpc-11"
}
}
resource "aws_subnet" "pubsn" {
  count=length(var.vpc_pub_sn_cidr)
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.vpc_pub_sn_cidr[count.index]
  tags = {
    Name = join("-",["pub","sn",count.index])
  }
}
resource "aws_subnet" "pvtsn" {
  count=length(var.vpc_pvt_sn_cidr)
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.vpc_pvt_sn_cidr[count.index]
  tags = {
    Name = join("-",["pvt","sn",count.index])
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "vpc-11-IG"
  }
}
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id
  route {  
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}
}
resource "aws_route_table_association" "rta_ass" {
  count=length(var.vpc_pub_sn_cidr)
  subnet_id      = aws_subnet.pubsn.*.id[count.index]
  route_table_id = aws_route_table.rt1.id
}
resource "aws_eip" "eip" {
  
}
resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pubsn.*.id[0]

  tags = {
    Name = "NAT"
 }
 }
resource "aws_default_route_table" "rt2" {
  default_route_table_id = aws_vpc.vpc1.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NAT.id
  }
  }
