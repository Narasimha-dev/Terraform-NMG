output instance_id {
	value = ["${aws_instance.main.*.id}"]
}

output availability_zone {
	value = ["${aws_instance.main.*.availability_zone}"]
}

output key_name {
	value = ["${aws_instance.main.*.key_name}"]
}

output public_dns {
	value = ["${aws_instance.main.*.public_dns}"]
}

output public_ip {
	value = ["${aws_instance.main.*.public_ip}"]
}

output private_ip {
	value = ["${aws_instance.main.*.private_ip}"]
}

output instance_state {
	value = ["${aws_instance.main.*.instance_state}"]
}
