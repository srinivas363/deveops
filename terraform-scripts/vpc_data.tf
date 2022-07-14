data aws_availability_zones "az"{
}
resource aws_vpc "vpc1"{
	cidr_block=var.v_vpc_cidr
	tags={
		Name="myvpc12"
	}
}
resource aws_subnet "sn1"{
	count=length(data.aws_availability_zones.az.names)*2 
	vpc_id=aws_vpc.vpc1.id
	availability_zone=element(data.aws_availability_zones.az.names,count.index)
	cidr_block=cidrsubnet("10.0.0.0/16", 8, count.index)
	 tags={
	"Name"=count.index<3?"pub-${count.index}":"prv-${count.index}"
  }
}

resource aws_internet_gateway "igw"{
	vpc_id=aws_vpc.vpc1.id
}
resource aws_route_table "rt1"{
	vpc_id=aws_vpc.vpc1.id
	route{
		cidr_block="0.0.0.0/0"
		gateway_id=aws_internet_gateway.igw.id
	}
}
resource "aws_route_table_association" "pubsns" {
  count=length(data.aws_availability_zones.az.names)
  subnet_id      = aws_subnet.sn1.*.id[count.index]
  route_table_id = aws_route_table.rt1.id
 
}
resource "aws_instance" "i1"{
   count=length(data.aws_availability_zones.az.names)
   ami="ami-02ee763250491e04a"
   instance_type="t2.micro"
   subnet_id=aws_subnet.sn1.*.id[count.index]
}
output "vpc_id"{
   value=aws_vpc.vpc1.id
}
output "sns_id"{
   value=aws_subnet.sn1.*.id
}