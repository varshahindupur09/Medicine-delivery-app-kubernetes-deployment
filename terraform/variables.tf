variable "aws_region" {
    description = "AWS region for the infrastructure"
    type        = string
    default     = "us-east-1"
}
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "mediapp-eks-cluster"
}
variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.31"
}
variable "vpc_id" {
  description = "VPC ID where EKS will be deployed"
  type        = string
  default     = "vpc-060d208b21c0b0589" # VPC ID
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
  default     = ["subnet-0cc68e9ba42caf9ac", "subnet-096e6ac6a0c4bb872"] # public subnets
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
  default     = ["subnet-0026a87ff0d128c6d", "subnet-0b270c23379d6be90"] # private subnets
}