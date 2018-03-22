variable "key_name" {
    description = "Name of the SSH keypair to use in AWS."
}

variable "key_path" {
    description = "Path to the private portion of the SSH key specified."
}

variable "aws_region" {
    description = "AWS region to launch servers."
}

variable "subnet_id" {
    description = "Subnet ID to use in VPC"
}

variable "instance_type" {
    description = "Instance type"
}

variable "security_group_ids" {
    description = "Instance type"
}

