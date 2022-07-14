/*
resource "aws_key_pair" "key1" {
		key_name="mykey1"
		public_key=file("./mykey1.pub")
}
resource "aws_security_group" "sg1" {
  name        = "sg1"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0825b0a6a6e4cc27a"
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}
resource "aws_instance" "i1"{
	ami="ami-04ff9e9b51c1f62ca"
	instance_type="t2.micro"
	subnet_id="subnet-0aab80066af26ee2a"
	vpc_security_group_ids=[aws_security_group.sg1.id]
	key_name=aws_key_pair.key1.key_name
	provisioner "file" {
		source="./sheshi.sh"
		destination ="/tmp/sheshi.sh"
		connection {
			type="ssh"
			user="ubuntu"
			private_key=file("./mykey1")
			host=self.public_ip
		}
	}
}
*/