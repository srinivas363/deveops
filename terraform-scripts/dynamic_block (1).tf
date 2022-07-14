variable "v_port"{
	type=list(string)
	default=["22","80","90","8080"]
}	  
  
resource "aws_security_group" "sg1" {
  name        = "sg2341-28"
  description = "sg2341-28"
  vpc_id      = "vpc-0825b0a6a6e4cc27a"
  
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
