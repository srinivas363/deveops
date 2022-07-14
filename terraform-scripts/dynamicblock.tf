variable "v_port"{
	type=list(string)
	default=["22","80","90","8080"]
}
resource "aws_security_group" "sg1" {
  name        = "sg4855"
  description = "security"
  vpc_id      = "vpc-0b32ab6210f5451f4"
  
  dynamic "ingress" {
   for_each=toset(var.v_port)
  content  {
    description      = "TLS from VPC"
    from_port        = ingress.key
    to_port          = ingress.key
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  }  

}	 