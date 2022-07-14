variable "sai"{
  default= "srinivas"
  }
variable "abc"{
 type=list
 default=[10,20,30,40]
 }
variable "bbc"{
 type=list(string)
 default=["vg","rt","hu","ji"]
 }
variable "cbc"{
 type=map(string)
 default={
 "course"="aws"
 "fee"="2ok"
 }
 }
variable "ebc"{
 type=map(string)
 default={
 "duration"="90"
 "time"="2-hrs"
 }
 }
locals {
 merged_variables=concat(var.abc,var.bbc)
 }
output "out1"{
  value=var.abc.1
  }
output "out2"{
  value=var.bbc.0
  }
output "out3"{
  value=element(var.abc,1)
  }
output "out4"{
  value=lookup(var.cbc,"course")
  }
output "out5"{
  value=lookup(var.cbc,"date","22/10/22")
  }
output "merged"{ 
  value= local.merged_variables
  }
output "subst1" {
  value= substr(var.sai,0,4)
  }
output "subst2" {
  value= substr(var.sai,-5,-1)
  }
