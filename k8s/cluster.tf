resource "digitalocean_droplet" "master" {
    name = "master"
    image = "ubuntu-16-04-x64"
    size = "2gb"
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
      script = "files/k8s_bootstrap.sh" 
      }
    provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # initialize the Master node.
      "kubeadm init  --pod-network-cidr=192.168.0.0/16 --token=ff6edf.38d10317aa6fa57e"
    ]
  }

    provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "mkdir -p /root/.kube",
      "sudo cp -i /etc/kubernetes/admin.conf /root/.kube/config",
      "sudo chown $(id -u):$(id -g) /root/.kube/config",
      "kubectl apply -f https://docs.projectcalico.org/v3.0/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml"
    ]
  }
    
}

resource "digitalocean_droplet" "worker1" {
    name = "worker1"
    image = "ubuntu-16-04-x64"
    size = "2gb"
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
      script = "files/k8s_bootstrap.sh" 
      }
    provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # Join the Cluster.
      "kubeadm join --skip-preflight-checks --token ff6edf.38d10317aa6fa57e '${digitalocean_droplet.master.ipv4_address}':6443 --discovery-token-unsafe-skip-ca-verification"
    ]
  }

}

resource "digitalocean_droplet" "worker2" {
    name = "worker2"
    image = "ubuntu-16-04-x64"
    size = "2gb"
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
      script = "files/k8s_bootstrap.sh" 
      }
    provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # Join the Cluster.
      "kubeadm join --skip-preflight-checks --token ff6edf.38d10317aa6fa57e '${digitalocean_droplet.master.ipv4_address}':6443 --discovery-token-unsafe-skip-ca-verification",
     ]
}

}

