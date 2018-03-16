- Clone this Repository.

- Get into the Repository.
```
$ cd terraform-practice/k8s
```

- Update the `terraform.tfvars ` file.
```
$ vi terraform.tfvars

do_token = "2c7736fefafff443434fadf93ec976d0de.........................."
pub_key = "/root/.ssh/id_rsa.pub"
pvt_key = "/root/.ssh/id_rsa"
ssh_fingerprint = "6c:20:67:1c:59:b2:67:61..........................."
```

Update `do_token` with Digital Oceans Token.
Update `pub_key` with Public Key address.
Update `pvt_key` with Private Key address.
Update `ssh_fingerprint` with Private Key address.

- You will get `ssh_fingerprint` required for next commands.
If your private key is located at `~/.ssh/id_rsa`, use the following command to get the MD5 fingerprint of your public key:

```
$ ssh-keygen -E md5 -lf ~/.ssh/id_rsa.pub | awk '{print $2}'

md5:2c:4d:c6:6c:20:67:1c:59:b2:67:61::a0:43:29:82:7d
```

### Run Terraform to Create K8s cluster.

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

- Lets run the `terraform plan` command which will show what Terraform will attempt to do to build the infrastructure that we have described . We have to specify the values of all of the variables listed below.
```
$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + digitalocean_droplet.master
      id:                   <computed>
      disk:                 <computed>
      image:                "ubuntu-16-04-x64"
      ipv4_address:         <computed>
      ipv4_address_private: <computed>
      ipv6:                 "true"
      ipv6_address:         <computed>
      ipv6_address_private: <computed>
      locked:               <computed>
      name:                 "master"
      price_hourly:         <computed>
      price_monthly:        <computed>
      private_networking:   "false"
      region:               "ams3"
      resize_disk:          "true"
      size:                 "2gb"
      ssh_keys.#:           "1"
      ssh_keys.0:           "51:2c:ad:79:1b:2c:4d:c6:6c:20:67:1c:59:b2:67:61"
      status:               <computed>
      vcpus:                <computed>

  + digitalocean_droplet.worker1
      id:                   <computed>
      disk:                 <computed>
      image:                "ubuntu-16-04-x64"
      ipv4_address:         <computed>
      ipv4_address_private: <computed>
      ipv6:                 "true"
      ipv6_address:         <computed>
      ipv6_address_private: <computed>
      locked:               <computed>
      name:                 "worker1"
      price_hourly:         <computed>
      price_monthly:        <computed>
      private_networking:   "false"
      region:               "ams3"
      resize_disk:          "true"
      size:                 "2gb"
      ssh_keys.#:           "1"
      ssh_keys.0:           "51:2c:ad:79:1b:2c:4d:c6:6c:20:67:1c:59:b2:67:61"
      status:               <computed>
      vcpus:                <computed>

  + digitalocean_droplet.worker2
      id:                   <computed>
      disk:                 <computed>
      image:                "ubuntu-16-04-x64"
      ipv4_address:         <computed>
      ipv4_address_private: <computed>
      ipv6:                 "true"
      ipv6_address:         <computed>
      ipv6_address_private: <computed>
      locked:               <computed>
      name:                 "worker2"
      price_hourly:         <computed>
      price_monthly:        <computed>
      private_networking:   "false"
      region:               "ams3"
      resize_disk:          "true"
      size:                 "2gb"
      ssh_keys.#:           "1"
      ssh_keys.0:           "51:2c:ad:79:1b:2c:4d:c6:6c:20:67:1c:59:b2:67:61"
      status:               <computed>
      vcpus:                <computed>


Plan: 3 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

- Run the following `terraform apply` command to execute the current plan. Again, specify all the values for the variables below.
```
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + digitalocean_droplet.master
      id:                   <computed>
      disk:                 <computed>
      image:                "ubuntu-16-04-x64"
      ipv4_address:         <computed>
      ipv4_address_private: <computed>
      ipv6:                 "true"
      ipv6_address:         <computed>
      ipv6_address_private: <computed>
      locked:               <computed>
      name:                 "master"
      price_hourly:         <computed>
      price_monthly:        <computed>
      private_networking:   "false"
      region:               "ams3"
      resize_disk:          "true"
      size:                 "2gb"
      ssh_keys.#:           "1"
      ssh_keys.0:           "51:2c:ad:79:1b:2c:4d:c6:6c:20:67:1c:59:b2:67:61"
      status:               <computed>
      vcpus:                <computed>

  + digitalocean_droplet.worker1
      id:                   <computed>
      disk:                 <computed>
      image:                "ubuntu-16-04-x64"
      ipv4_address:         <computed>
      ipv4_address_private: <computed>
      ipv6:                 "true"
      ipv6_address:         <computed>
      ipv6_address_private: <computed>
      locked:               <computed>
      name:                 "worker1"
      price_hourly:         <computed>
      price_monthly:        <computed>
      private_networking:   "false"
      region:               "ams3"
      resize_disk:          "true"
      size:                 "2gb"
      ssh_keys.#:           "1"
      ssh_keys.0:           "51:2c:ad:79:1b:2c:4d:c6:6c:20:67:1c:59:b2:67:61"
      status:               <computed>
      vcpus:                <computed>

  + digitalocean_droplet.worker2
      id:                   <computed>
      disk:                 <computed>
      image:                "ubuntu-16-04-x64"
      ipv4_address:         <computed>
      ipv4_address_private: <computed>
      ipv6:                 "true"
      ipv6_address:         <computed>
      ipv6_address_private: <computed>
      locked:               <computed>
      name:                 "worker2"
      price_hourly:         <computed>
      price_monthly:        <computed>
      private_networking:   "false"
      region:               "ams3"
      resize_disk:          "true"
      size:                 "2gb"
      ssh_keys.#:           "1"
      ssh_keys.0:           "51:2c:ad:79:1b:2c:4d:c6:6c:20:67:1c:59:b2:67:61"
      status:               <computed>
      vcpus:                <computed>


Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
.
.
.
.

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

master_addresses = 178.62.232.148
worker1_addresses = 159.65.193.224
worker2_addresses = 159.65.204.33
```

- Take SSH access to the `master`.
```
$ ssh root@178.62.232.148

root@master:~# kubectl get nodes
NAME      STATUS    ROLES     AGE       VERSION
master    Ready     master    6m        v1.9.4
worker1   Ready     <none>    4m        v1.9.4
worker2   Ready     <none>    4m        v1.9.4

```

- Destroy the Cluster.
```
$ terraform destroy
digitalocean_droplet.master: Refreshing state... (ID: 86076440)
digitalocean_droplet.worker2: Refreshing state... (ID: 86076777)
digitalocean_droplet.worker1: Refreshing state... (ID: 86076776)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  - digitalocean_droplet.master

  - digitalocean_droplet.worker1

  - digitalocean_droplet.worker2


Plan: 0 to add, 0 to change, 3 to destroy.

Do you really want to destroy?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

digitalocean_droplet.worker2: Destroying... (ID: 86076777)
digitalocean_droplet.worker1: Destroying... (ID: 86076776)
digitalocean_droplet.worker2: Still destroying... (ID: 86076777, 10s elapsed)
digitalocean_droplet.worker1: Still destroying... (ID: 86076776, 10s elapsed)
digitalocean_droplet.worker2: Destruction complete after 13s
digitalocean_droplet.worker1: Destruction complete after 14s
digitalocean_droplet.master: Destroying... (ID: 86076440)
digitalocean_droplet.master: Still destroying... (ID: 86076440, 10s elapsed)
digitalocean_droplet.master: Destruction complete after 13s

Destroy complete! Resources: 3 destroyed.

```
