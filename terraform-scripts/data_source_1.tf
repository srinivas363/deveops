/*
data aws_availability_zones "az"{
}
resource aws_ebs_volume "v1"{
	count=length(data.aws_availability_zones.az.names)
	availability_zone=data.aws_availability_zones.az.names[count.index]
	size=2
	type="gp2"
}

output "azs"{
	value=data.aws_availability_zones.az.names
}
output "azscnt"{
	value=length(data.aws_availability_zones.az.names)
}

*/