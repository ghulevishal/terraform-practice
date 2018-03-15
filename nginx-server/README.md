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

- You will get `ssh_fingerprint` required for next commands.
If your private key is located at ~/.ssh/id_rsa, use the following command to get the MD5 fingerprint of your public key:

```
$ ssh-keygen -E md5 -lf ~/.ssh/id_rsa.pub | awk '{print $2}'

md5:2c:4d:c6:6c:20:67:1c:59:b2:67:61::a0:43:29:82:7d
```

- Lets run the `terraform plan` command which will show what Terraform will attempt to do to build the infrastructure that we have described . We have to specify the values of all of the variables listed below:

```
$ terraform plan \
  -var "do_token=163dbe716842c7736fefafff443434fadf93ec976d0de......................." \
  -var "pub_key=$HOME/.ssh/id_rsa.pub" \
  -var "pvt_key=$HOME/.ssh/id_rsa" \
  -var "ssh_fingerprint=2c:4d:c6:6c:20:67:1c:59:b2:67:61::a0:43:29:82:7d"
  
  
  
  
  
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + digitalocean_droplet.nginx-server
      id:                   <computed>
      disk:                 <computed>
      image:                "ubuntu-16-04-x64"
      ipv4_address:         <computed>
      ipv4_address_private: <computed>
      ipv6:                 "true"
      ipv6_address:         <computed>
      ipv6_address_private: <computed>
      locked:               <computed>
      name:                 "nginx-server"
      price_hourly:         <computed>
      price_monthly:        <computed>
      private_networking:   "false"
      region:               "ams3"
      resize_disk:          "true"
      size:                 "512mb"
      ssh_keys.#:           "1"
      ssh_keys.0:           "2c:4d:c6:6c:20:67:1c:59:b2:67:61::a0:43:29:82:7d"
      status:               <computed>
      vcpus:                <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

```

- Run the following `terraform apply` command to execute the current plan. Again, specify all the values for the variables below.
```
$ terraform apply \
  -var "do_token=163dbe716842c7736fefafff443434fadf93ec976d0de......................." \
  -var "pub_key=$HOME/.ssh/id_rsa.pub" \
  -var "pvt_key=$HOME/.ssh/id_rsa" \
  -var "ssh_fingerprint=2c:4d:c6:6c:20:67:1c:59:b2:67:61::a0:43:29:82:7d"
  
  
  
  An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + digitalocean_droplet.nginx-server
      id:                   <computed>
      disk:                 <computed>
      image:                "ubuntu-16-04-x64"
      ipv4_address:         <computed>
      ipv4_address_private: <computed>
      ipv6:                 "true"
      ipv6_address:         <computed>
      ipv6_address_private: <computed>
      locked:               <computed>
      name:                 "nginx-server"
      price_hourly:         <computed>
      price_monthly:        <computed>
      private_networking:   "false"
      region:               "ams3"
      resize_disk:          "true"
      size:                 "512mb"
      ssh_keys.#:           "1"
      ssh_keys.0:           "2c:4d:c6:6c:20:67:1c:59:b2:67:61::a0:43:29:82:7d"
      status:               <computed>
      vcpus:                <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

digitalocean_droplet.nginx-server: Creating...
  disk:                 "" => "<computed>"
  image:                "" => "ubuntu-16-04-x64"
  ipv4_address:         "" => "<computed>"
  ipv4_address_private: "" => "<computed>"
  ipv6:                 "" => "true"
  ipv6_address:         "" => "<computed>"
  ipv6_address_private: "" => "<computed>"
  locked:               "" => "<computed>"
  name:                 "" => "nginx-server"
  price_hourly:         "" => "<computed>"
  price_monthly:        "" => "<computed>"
  private_networking:   "" => "false"
  region:               "" => "ams3"
  resize_disk:          "" => "true"
  size:                 "" => "512mb"
  ssh_keys.#:           "" => "1"
  ssh_keys.0:           "" => "2c:4d:c6:6c:20:67:1c:59:b2:67:61::a0:43:29:82:7d"
  status:               "" => "<computed>"
  vcpus:                "" => "<computed>"
digitalocean_droplet.nginx-server: Still creating... (10s elapsed)
..
..
.
.
.
digitalocean_droplet.nginx-server: Creation complete after 1m16s (ID: 85926534)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

```

### Destroy the Infrastructure and Application.

To Destro the Infrastructure and Application we recenty create, Run the following `terraform destroy` command and specify all the values for the variables below.
```
$ $ terraform destroy \
  -var "do_token=163dbe716842c7736fefafff443434fadf93ec976d0de......................." \
  -var "pub_key=$HOME/.ssh/id_rsa.pub" \
  -var "pvt_key=$HOME/.ssh/id_rsa" \
  -var "ssh_fingerprint=2c:4d:c6:6c:20:67:1c:59:b2:67:61::a0:43:29:82:7d"
  
  
  
  
  digitalocean_droplet.nginx-server: Refreshing state... (ID: 85926534)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  - digitalocean_droplet.nginx-server


Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

digitalocean_droplet.nginx-server: Destroying... (ID: 85926534)
digitalocean_droplet.nginx-server: Still destroying... (ID: 85926534, 10s elapsed)
digitalocean_droplet.nginx-server: Destruction complete after 13s

Destroy complete! Resources: 1 destroyed.

```




