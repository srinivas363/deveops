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
	CreatedBy="sheshi"
	}
	}
output "test1"{
  value=merge({Name="${var.v_prefix}-vpc"},local.common_tags)
				}