//-------------------------------------------------------------------
// AWS settings
//-------------------------------------------------------------------

variable "aws_region" {
  type        = "string"
  default     = "us-west-2"
  description = "AWS Region"
}

variable "aws_creds_file" {
  type        = "string"
  default     = "/home/rkennedy/.aws/credentials"
  description = "AWS Credentials File"
}

variable "aws_profile" {
  type        = "string"
  default     = "ryno75"
  description = "AWS Profile"
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

// AutoScaling Group Vars

variable "asg_name" {
  type        = "string"
  default     = "wiki-asg"
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

variable "asg_ami" {
  type        = "string"
  default     = "ami-7172b611"
  description = "AMI ID. Ensure it is compatible with the instance type. Not all AMIs allow all instance types"
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

// ELB Vars

variable "elb_name" {
  type        = "string"
  default     = "wiki.mcgooglesoft.com"
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

variable "domain_name" {
  default     = "wiki.mcgooglesoft.com"
  description = "DNS Domain Name for wiki"
}

variable "download_url" {
  default     = "https://depot.mcgooglesoft.com/jamwiki-1.3.2.war"
  description = "URL to download jamwiki war"
}
