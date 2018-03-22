output "master_addresses" { 
 value = "${aws_instance.master.public_ip}"
}

output "worker1_addresses" { 
 value = "${aws_instance.worker1.public_ip}"
}

output "worker2_addresses" { 
 value = "${aws_instance.worker2.public_ip}"
}
