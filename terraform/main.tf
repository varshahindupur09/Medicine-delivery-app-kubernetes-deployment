provider "aws" {
    region = var.aws_region
}
module "eks" {
    source = "./eks"
    cluster_name = var.cluster_name
    cluster_version = var.cluster_version
    vpc_id = var.vpc_id
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
}