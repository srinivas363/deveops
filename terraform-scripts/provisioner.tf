resource "aws_key_pair" "mykp" {
  key_name="kp"
  public_key=file("./kp.pub")
  }
resource "aws_security_group" "sg1"{
  name="mysg1"
  description="allow tls"
  vpc_id="vpc-0dd38e96c91092588"
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
  ami           = "ami-02f3416038bdb17fb"
  instance_type = "t2.micro"
  subnet_id="subnet-0e5df7a9e621072e0"
  vpc_security_group_ids=[aws_security_group.sg1.id]
  key_name =aws_key_pair.mykp.key_name
  provisioner "file" {
    source = "./teju.sh"
	destination="/tmp/teju.sh"
	connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key=file("./kp")
      host     = self.public_ip
    }
 }
  provisioner "remote-exec" {
     inline=[
       "chmod +x /tmp/teju.sh",
       "sh /tmp/teju.sh",
        ]
        connection {
          type     = "ssh"
          user     = "ubuntu"
          private_key=file("./kp")
          host     = self.public_ip
 }
 }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> inv.txt"
 }
 }