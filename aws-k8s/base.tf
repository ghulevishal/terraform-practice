provider "aws" {
  access_key = "AKIAJFLQDQ5AM6EZ2HNA"
  secret_key = "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"
  region     = "us-west-1"
}

resource "aws_instance" "master" {
  ami           = "ami-07585467"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_id}"
  vpc_security_group_ids = [
    "${var.security_group_ids}",
  ]

  key_name = "${var.key_name}"

  tags {
    "Name" = "master"
  }

  connection {
    # The default username for our AMI
      type = "ssh"
      user = "ubuntu"
      agent = false

    # The path to your keyfile
      private_key = "${file(var.key_path)}"
    }
  provisioner "remote-exec" {
      script = "files/k8s_bootstrap.sh" 
      }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # initialize the Master node.
      "sudo kubeadm init  --pod-network-cidr=192.168.0.0/16 --token=ff6edf.38d10317aa6fa57e --apiserver-advertise-address='${aws_instance.master.public_ip}'",
      "mkdir -p $HOME/.kube",
      "sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config",
      "sudo chown $(id -u):$(id -g) $HOME/.kube/config",
      "kubectl apply -f https://docs.projectcalico.org/v3.0/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml"
    ]
  }
   
}

resource "aws_instance" "worker1" {
  ami           = "ami-07585467"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_id}"
  vpc_security_group_ids = [
    "${var.security_group_ids}",
  ]

  key_name = "${var.key_name}"
  tags {
    "Name" = "worker1"
  }
  connection {
    # The default username for our AMI
      type = "ssh"
      user = "ubuntu"
      agent = false

    # The path to your keyfile
      private_key = "${file(var.key_path)}"
    }
    provisioner "remote-exec" {
      script = "files/k8s_bootstrap.sh" 
      }
    provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # Join the Cluster.
      "sudo kubeadm join --skip-preflight-checks --token ff6edf.38d10317aa6fa57e '${aws_instance.master.public_ip}':6443 --discovery-token-unsafe-skip-ca-verification"
    ]
  }


}

resource "aws_instance" "worker2" {
  ami           = "ami-07585467"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_id}"
  vpc_security_group_ids = [
    "${var.security_group_ids}",
  ]

  key_name = "${var.key_name}"
  tags {
    "Name" = "worker2"
  }
  connection {
    # The default username for our AMI
      type = "ssh"
      user = "ubuntu"
      agent = false

    # The path to your keyfile
      private_key = "${file(var.key_path)}"
    }
    provisioner "remote-exec" {
      script = "files/k8s_bootstrap.sh" 
      }
    provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # Join the Cluster.
      "sudo kubeadm join --skip-preflight-checks --token ff6edf.38d10317aa6fa57e '${aws_instance.master.public_ip}':6443 --discovery-token-unsafe-skip-ca-verification"
    ]
  }


}



