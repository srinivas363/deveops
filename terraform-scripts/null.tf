/*
variable "v_temp" {
}
resource "aws_key_pair" "mykp" {
  key_name="kp"
  public_key=file("./kp.pub")
  }
resource "aws_security_group" "sg1"{
  name="mysg1"
  description="allow tls"
  vpc_id="vpc-081186952979ed19a"
  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "i1" {
  ami           = "ami-068257025f72f470d"
  instance_type = "t2.micro"
  subnet_id="subnet-0c61082865bc8ee24"
  vpc_security_group_ids=[aws_security_group.sg1.id]
  key_name =aws_key_pair.mykp.key_name
  }
  
resource null_resource "nr" {
    triggers={
     a=var.v_temp
	 }
    provisioner "file" {
       source="./teju.sh"
	   destination="/tmp/teju.sh"
	   connection {
           type="ssh"
           user="ubuntu"
           private_key=file("./kp")
           host=aws_instance.i1.public_ip
    }
 }

}
*/