filename:new10.tf
=================
variable "v_vpc_cidr"{
}
variable "v_pub_sns"{
  type=list
}
variable "v_pvt_sns"{
  type=list
}
variable "azs"{
  default=["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
}
variable "v_nat"{
  default="true"
}
variable "v_prefix"{
  default="NB"
}
locals {
  common_tags={
    Owner="srinu"
	CreatedBy="teju"
	}
	}
output "test1"{
  value=merge({Name="${var.v_prefix}-vpc"},local.common_tags)
				}
=================================================================================

filename: input.tfvars
======================
v_vpc_cidr="10.0.0.0/16"
v_pub_sns=["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24"]
v_pvt_sns=["10.0.3.0/24","10.0.4.0/24","10.0.5.0/24"]

=================================================================================
cmd:terraform apply -var-file input.tfvars
=======================================
resource "aws_vpc" "vpc1" {
  cidr_block = var.v_vpc_cidr
  tags= merge({Name="${var.v_prefix}-vpc"},local.common_tags)
  }
resource "aws_subnet" "pubsns" {
  count=length(var.v_pub_sns)
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.v_pub_sns[count.index]
  availability_zone=var.azs[count.index]
  tags = merge({Name="${var.v_prefix}-pubsn-${count.index}"},local.common_tags)
}
resource "aws_subnet" "pvtsns" {
  count=length(var.v_pvt_sns)
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.v_pvt_sns[count.index]
  availability_zone=var.azs[count.index]
  tags = merge({Name="${var.v_prefix}-pvtsn-${count.index}"},local.common_tags)
}
resource "aws_internet_gateway" "igw"{
  count=length(var.v_pub_sns)>0?1:0
  vpc_id=aws_vpc.vpc1.id
  }
resource "aws_route_table" "rt1" {
  count=length(var.v_pub_sns)>0?1:0
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.*.id[0]
		}
    tags=merge({Name="${var.v_prefix}-pubrt"},local.common_tags)
  }
resource "aws_route_table_association" "pubrt1ass" {
  count=length(var.v_pub_sns)
  subnet_id      = aws_subnet.pubsns.*.id[count.index]
  route_table_id = aws_route_table.rt1.*.id[0]
}
resource "aws_eip" "eip" {
}
resource "aws_nat_gateway" "nat" {
  count=var.v_nat=="true"?1:0
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pubsns.*.id[0]
  tags = {
    Name = "vNAT"
  }
  }
resource "aws_route_table" "rt2" {
  count=var.v_nat=="true"?1:0
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.*.id[0]
		}
    tags=merge({Name="${var.v_prefix}-pvtrt"},local.common_tags)
  }
resource "aws_route_table_association" "pvtrt1ass" {
  count=var.v_nat=="true"?length(var.v_pvt_sns):0
  subnet_id      = aws_subnet.pvtsns.*.id[count.index]
  route_table_id = aws_route_table.rt2.*.id[0]
}