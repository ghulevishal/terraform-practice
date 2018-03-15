- Create `provider.tf` as below.
```
$ vi provider.tf

variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

```

## DigitalOcean Resources

Each provider has its own specifications, which generally map to the API of its respective service provider. In the case of the DigitalOcean provider, we are able to define three types of resources:

    digitalocean_domain: DNS domain entries
    digitalocean_droplet: Droplets (i.e. VPS or servers)
    digitalocean_record: DNS records

Let's start by creating a droplet which will run an Nginx server.

- Create `nginx.tf` as below.
```
$ vim nginx.tf

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

```
Above file will create Digital Ocean Droplet and take SSH access to and install `nginx` on it.


### Run Terraform to Create Nginx Server.

- Initialize Terraform for our project. 
```
$ terraform init

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.digitalocean: version = "~> 0.1"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

```

- Lets run the following terraform plan command to see what Terraform will attempt to do to build the infrastructure you described (i.e. see the execution plan). You will have to specify the values of all of the variables listed below:
