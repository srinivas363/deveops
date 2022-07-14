variable "abc"{
  type=list
  }
variable "bbc"{
  type=list
  }
output "x" {
value= var.abc
}
output "y" {
value= var.bbc
}
output "z" {
value= length(var.abc)
}
output "w" {
value= length(var.bbc)
}