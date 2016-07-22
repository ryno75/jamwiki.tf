//-------------------------------------------------------------------

// AWS settings

//-------------------------------------------------------------------

variable "aws_region" {
  type        = "string"
  default     = "us-west-1"
  description = "AWS Region to use for provider"
}

variable "aws_secret_key" {}

variable "aws_access_key" {}

variable "aws_profile" {}

variable "environment" {
  type        = "string"
  default     = "dev"
  description = "The environment of the stack"
}

variable "vpc_cidr" {
  type        = "string"
  default     = "10.0.0.0/24"
  description = "RFC1918 compliant CIDR block. Must no larger than /16 or smaller than /28"
}

variable "public_subnets" {
  type        = "string"
  default     = "10.0.0.0/26,10.0.0.64/26"
  description = "Comma separated list of CIDRs to assign to public subnets"
}

variable "private_subnets" {
  type        = "string"
  default     = "10.0.0.128/26,10.0.0.192/26"
  description = "Comma separated list of CIDRs to assign to private subnets"
}

variable "vpc_name" {
  type        = "string"
  default     = "jamwiki-demo"
  description = "Name to assign the VPC"
}

variable "availability_zones" {
  type        = "string"
  default     = "us-west-2a,us-west-2b"
  description = "Comma separated list of AWS Availability zones"
}

variable "key_name" {
  default = "jw-demo"
}

// Puppet Secrets Bucket Vars

variable "puppet_bucket" {
  type        = "string"
  default     = "puppet-depot"
  description = "Puppet S3 bucket name"
}

variable "secrets_key_prefix" {
  type        = "string"
  default     = "secrets/"
  description = "Prefix for the secrets location/key in the Puppet S3 bucket"
}

// AutoScaling Group Vars

variable "asg_name" {
  type        = "string"
  default     = "wiki-asg"
  description = "AutoScaling Group Name"
}

variable "asg_instance_name" {
  type        = "string"
  default     = "wiki.mcgooglesoft.com"
  description = "AutoScaling Group Name"
}

variable "asg_sg_name" {
  type        = "string"
  default     = "wiki-asg-sg"
  description = "Wiki AutoScaling Security Group Name"
}

variable "aslc_name" {
  type        = "string"
  default     = "wiki-aslc"
  description = "AutoScaling Launch Configuration Name"
}

variable "amazon_ami" {
  type        = "map"
  description = "amzn-ami-hvm-2016.03.3.x86_64-gp2"

  default = {
    ap-northeast-1 = "ami-374db956"
    ap-northeast-2 = "ami-2b408b45"
    ap-south-1     = "ami-fdbed492"
    ap-southeast-1 = "ami-a69b49c5"
    ap-southeast-2 = "ami-10361e73"
    eu-central-1   = "ami-ea26ce85"
    eu-west-1      = "ami-f9dd458a"
    sa-east-1      = "ami-6dd04501"
    us-east-1      = "ami-7f6aa912"
    us-west-1      = "ami-594b0f39"
    us-west-2      = "ami-7172b611"
  }
}

variable "ubuntu_ami" {
  type        = "map"
  description = "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20160627"

  default = {
    ap-northeast-1 = "ami-b7d829d6"
    ap-northeast-2 = "ami-9a965cf4"
    ap-south-1     = "ami-7e94fe11"
    ap-southeast-1 = "ami-fc37e59f"
    ap-southeast-2 = "ami-a387afc0"
    eu-central-1   = "ami-26e70c49"
    eu-west-1      = "ami-a4d44ed7"
    sa-east-1      = "ami-78a93c14"
    us-east-1      = "ami-ddf13fb0"
    us-west-1      = "ami-b20542d2"
    us-west-2      = "ami-b9ff39d9"
  }
}

variable "asg_instance_type" {
  type        = "string"
  default     = "t2.micro"
  description = "EC2 Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types "
}

variable "asg_health_check_type" {
  type        = "string"
  default     = "ELB"
  description = "AutoScaling Health Check type. Either EC2 or ELB."
}

variable "asg_health_check_grace_period" {
  type        = "string"
  default     = "1800"
  description = "AutoScaling Health Check type. Either EC2 or ELB."
}

variable "asg_number_of_instances" {
  type        = "string"
  default     = 1
  description = "Desired number of instances in AutoScaling Group"
}

variable "asg_min_number_of_instances" {
  type        = "string"
  default     = 1
  description = "Minimum number of instances in AutoScaling Group"
}

variable "bastion_instance_type" {
  type        = "string"
  default     = "t2.micro"
  description = "EC2 Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types "
}

variable "bastion_sg_name" {
  type        = "string"
  default     = "bastion-sg"
  description = "Bastion Host ASG Security Group Name"
}

variable "bastion_whitelist" {
  type        = "string"
  default     = "98.247.8.3/32,50.199.2.65/32"
  description = "Comma separated list of CIDRs for Bastion Host SSH access"
}

variable "bastion_fqdn" {
  default     = "bastion.mcgooglesoft.com"
  description = "DNS Domain Name for Bastion host"
}

variable "rds_engine" {
  type        = "string"
  default     = "mysql"
  description = "RDS Database Engine Type"
}

variable "rds_engine_version" {
  type        = "string"
  default     = "5.6.27"
  description = "RDS Database Engine Version"
}

variable "rds_parameter_group" {
  type        = "string"
  default     = "default.mysql5.6"
  description = "RDS Database Instance Allocated Storage (in GB)"
}

variable "rds_instance_name" {
  type        = "string"
  default     = "jamwiki-database"
  description = "RDS Database Instance Type"
}

variable "rds_instance_type" {
  type        = "string"
  default     = "db.t2.micro"
  description = "RDS Database Instance Type"
}

variable "rds_allocated_storage" {
  type        = "string"
  default     = "5"
  description = "RDS Database Instance Allocated Storage (in GB)"
}

variable "rds_storage_type" {
  type        = "string"
  default     = "gp2"
  description = "RDS Database Instance Storage Type (magnetic, gp2, or io1)"
}

variable "rds_multi_az" {
  type        = "string"
  default     = "false"
  description = "Launch as MultiAZ RDS instance (true|false)"
}

variable "rds_sg_name" {
  type        = "string"
  default     = "rds-sg"
  description = "RDS Database Security Group Name"
}

variable "database_fqdn" {
  type        = "string"
  default     = "wikidb.mcgooglesoft.com"
  description = "DNS CNAME to RDS DB Instance"
}

variable "database_name" {
  type        = "string"
  default     = "jwdb"
  description = "Database Name"
}

variable "database_username" {
  type        = "string"
  default     = "jwdbadmin"
  description = "Database Admin Username"
}

variable "database_password" {
  type        = "string"
  description = "Database Admin Password"
}

variable "database_port" {
  type        = "string"
  default     = "5432"
  description = "RDS Database TCP Port"
}

// ELB Vars

variable "elb_name" {
  type        = "string"
  default     = "jamwiki-elb"
  description = "ELB Name"
}

variable "elb_sg_name" {
  type        = "string"
  default     = "wiki-elb-sg"
  description = "Wiki ELB Security Group Name"
}

variable "elb_listener_port" {
  default = 443
}

variable "elb_instance_port" {
  default = 8080
}

variable "elb_listener_protocol" {
  default = "HTTPS"
}

variable "elb_instance_protocol" {
  default = "HTTP"
}

variable "elb_health_check" {
  default     = "HTTP:8080/"
  description = "Health check for jamwiki service"
}

variable "elb_certificate_arn" {
  default = "arn:aws:acm:us-west-2:787594773047:certificate/a49a329f-0a0c-4bb8-9c59-621fc9c0e4f4"
}

variable "elb_whitelist_cidr" {
  default = "0.0.0.0/0"
}

//-------------------------------------------------------------------

// App settings

//-------------------------------------------------------------------

variable "user" {
  default = "ec2-user"
}

variable "hosted_zone_id" {
  default     = "Z25NGXBPOFIG35"
  description = "AWS Route53 Hosted Zone ID"
}

variable "wiki_fqdn" {
  default     = "wiki.mcgooglesoft.com"
  description = "DNS Domain Name for wiki"
}
