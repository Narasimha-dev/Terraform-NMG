output "vpc_id"{
        value = length(aws_vpc.vpc) > 0 ? aws_vpc.vpc[0].id : ""
}

output "sub_pub1"{
        value =  length(aws_subnet.sub_pub1) > 0 ? aws_subnet.sub_pub1[0].id : ""
}

output "sub_pub2"{
        value = length(aws_subnet.sub_pub2) > 0 ? aws_subnet.sub_pub2[0].id : ""
}

output "sub_pvt1"{
        value = length(aws_subnet.sub_prv1) > 0 ? aws_subnet.sub_prv1[0].id : ""
}

output "sub_pvt2"{
        value = length(aws_subnet.sub_prv2) > 0 ? aws_subnet.sub_prv2[0].id : ""
}
