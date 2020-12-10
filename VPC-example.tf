provider "aws" {
  region = "eu-west-1"
}


module "s3_bucket" {
  source = "github.com/terraform-aws-modules/terraform-aws-s3-bucket"

  bucket        = "terra-mappa"
  acl           = "private"

  # Block public access
  block_public_acls = true
  ignore_public_acls = true
  block_public_policy = true
  restrict_public_buckets = true

  tags = {
    Owner       = "Bence"
    Environment = "dev"
    Project     = "terraform-task"
  }
}

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"

  name = "Bence-terra-example"

  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  # VPC endpoint for S3
  enable_s3_endpoint = true

  # arn:aws:s3:::terra-mappa

  public_subnet_tags = {
    Name = "overridden-name-public"
  }

  tags = {
    Owner       = "Bence"
    Environment = "dev"
    Project     = "terraform-task"
  }

  vpc_tags = {
    Name = "terraform-vpc"
  }
  vpc_endpoint_tags = {
    Project  = "terraform-task"
    Endpoint = "true"
  }

}
