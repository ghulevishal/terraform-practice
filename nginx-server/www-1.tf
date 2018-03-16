resource "digitalocean_droplet" "nginx-server" {
    name = "nginx-server"
    image = "ubuntu-16-04-x64"
    size = "512mb"
    region = "ams3"
    ipv6 = true
    private_networking = false
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
    connection {
      user = "root"
      type = "ssh"
      private_key = "${file(var.pvt_key)}"
      timeout = "2m"
      }
    provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt-get update",
      "sudo apt-get -y install nginx"
    ]
  }
}

