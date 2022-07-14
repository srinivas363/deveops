resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags={
	"Name"="tfvpc"
  }
}
resource "aws_subnet" "sn1"{
	cidr_block = "10.0.0.0/24"
	availability_zone="ap-south-1a"
	vpc_id=aws_vpc.main.id
	tags={
	"Name"="tfvpc-sn1"
  }
}
resource "aws_subnet" "sn2"{
	cidr_block = "10.0.1.0/24"
	availability_zone="ap-south-1b"
	vpc_id=aws_vpc.main.id
	tags={
	"Name"="tfvpc-sn2"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main"
  }
}
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.main.id
  route{
	cidr_block="0.0.0.0/0"
	gateway_id=aws_internet_gateway.igw.id
  }
}  
resource "aws_route_table_association" "sn1rt1" {
  subnet_id      = aws_subnet.sn1.id
  route_table_id = aws_route_table.rt1.id
}
resource "aws_security_group" "sg1"{
	 vpc_id = aws_vpc.main.id
	 name        ="sg1tf"
	 description ="sg1tf"
	 ingress{
	    from_port="22"
		to_port="22"
		protocol="tcp"
		cidr_blocks=["0.0.0.0/0"]
	 }
	 ingress{
	    from_port="80"
		to_port="80"
		protocol="tcp"
		cidr_blocks=["0.0.0.0/0"]
	 }
	 egress{
	    from_port="0"
		to_port="0"
		protocol="-1"
		cidr_blocks=["0.0.0.0/0"]
	 }
}
resource "aws_instance" "i1"{
	ami="ami-068257025f72f470d"
	instance_type="t2.micro"
	vpc_security_group_ids=[aws_security_group.sg1.id]
	associate_public_ip_address="true"
	subnet_id=aws_subnet.sn1.id
	user_data=file("./1.sh")
}
	
