#!/bin/bash

sudo apt-get update 
sudo apt-get install -y apt-transport-https
echo "Installing K8s"
sudo chown -R $(id -u):$(id -g) /etc/apt/*
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm docker.io
