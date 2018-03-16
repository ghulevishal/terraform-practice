output "master_addresses" { 
 value = "${digitalocean_droplet.master.ipv4_address}"
}

output "worker1_addresses" { 
 value = "${digitalocean_droplet.worker1.ipv4_address}"
}

output "worker2_addresses" { 
 value = "${digitalocean_droplet.worker2.ipv4_address}"
}
