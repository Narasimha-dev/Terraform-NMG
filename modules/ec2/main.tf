
resource "aws_instance" "main" {
	count 			    = var.instance_count
	ami           		    = var.AMIS[var.region]
	instance_type 		    = var.instance_type
	subnet_id 		    = var.subnet_id
	key_name      		    = var.key_name
    	vpc_security_group_ids 	    = var.vpc_security_group_ids
	monitoring                  = var.monitoring
	associate_public_ip_address = var.associate_public_ip_address
	ebs_optimized 		    = var.ebs_optimized
	
	dynamic "root_block_device" {
		for_each 	= var.root_block_device
		content {
		  delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
		  encrypted             = lookup(root_block_device.value, "encrypted", null)
		  iops                  = lookup(root_block_device.value, "iops", null)
		  kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
		  volume_size           = lookup(root_block_device.value, "volume_size", null)
		  volume_type           = lookup(root_block_device.value, "volume_type", null)
		}
	}

	dynamic "ebs_block_device" {
		for_each 	= var.ebs_block_device
		content {
		  delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
		  device_name           = ebs_block_device.value.device_name
		  encrypted             = lookup(ebs_block_device.value, "encrypted", null)
		  iops                  = lookup(ebs_block_device.value, "iops", null)
		  kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
		  snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
		  volume_size           = lookup(ebs_block_device.value, "volume_size", null)
		  volume_type           = lookup(ebs_block_device.value, "volume_type", null)
		}
	}

	dynamic "ephemeral_block_device" {
		for_each 	= var.ephemeral_block_device
		content {
		  device_name  		= ephemeral_block_device.value.device_name
		  no_device   		= lookup(ephemeral_block_device.value, "no_device", null)
		  virtual_name 		= lookup(ephemeral_block_device.value, "virtual_name", null)
		}
	}

	dynamic "network_interface" {
		for_each 	= var.network_interface
		content {
		  device_index          = network_interface.value.device_index
		  network_interface_id  = lookup(network_interface.value, "network_interface_id", null)
		  delete_on_termination = lookup(network_interface.value, "delete_on_termination", false)
		}
	}
	
	provisioner "file" {
		source      	= var.file_source_path
		destination 	= "/tmp/script.sh"
	}
	
	provisioner "remote-exec" {
		inline = [
			"chmod +x /tmp/script.sh",
			"sudo sed -i -e 's/\r$//' /tmp/script.sh",  # Remove the spurious CR characters.
			"sudo /tmp/script.sh",
		]
    	}
	
    	connection {
		host        	= coalesce(self.public_ip, self.private_ip)
		type        	= "ssh"
		user        	= var.INSTANCE_USERNAME
		private_key 	= file(var.PATH_TO_PRIVATE_KEY)
	}
	
	tags 	= merge(
		var.additional_tags,
		{
			Name = "${var.tag}"
		},
	)
	
	volume_tags = merge(
		var.additional_volume_tags,
		{
			Name = "${var.tag}"
		},
	)
}
