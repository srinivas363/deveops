variable "v_vpc_id"{
	default="vpc-0825b0a6a6e4cc27a"
}
data "aws_subnet_ids" "sns" {
    vpc_id = var.v_vpc_id
}
data "aws_subnet" "sndet" {
  for_each=toset(data.aws_subnet_ids.sns.*.ids)
  id =each.key
}
output "snids"{
	value=data.aws_subnet_ids.sns.*.ids
}

output "snidlist"{
	value=tolist(data.aws_subnet_ids.sns.*.ids)
}


