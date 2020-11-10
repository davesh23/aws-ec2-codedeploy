provider "aws" {
  region = "us-east-1"
}

#####
# Vpc
#####

module "vpc" {
  source = "../../modules/aws-vpc"

  vpc-location                 = "Virginia"
  namespace                    = "cloudgeeks.ca"
  name                         = "vpc"
  stage                        = "ec2-dev"
  map_public_ip_on_launch      = "true"
  total-nat-gateway-required   = "1"
  create_database_subnet_group = "false"
  vpc-cidr                     = "10.20.0.0/16"
  vpc-public-subnet-cidr       = ["10.20.1.0/24", "10.20.2.0/24"]
  vpc-private-subnet-cidr      = ["10.20.4.0/24", "10.20.5.0/24"]
  vpc-database_subnets-cidr    = ["10.20.7.0/24", "10.20.8.0/24"]
}

module "ec2" {
  source                      = "../../modules/aws-ec2"
  namespace                   = "cloudgeeks.ca"
  stage                       = "dev"
  name                        = "ec2"
  key_name                    = "ec2"
  instance_count              = 1
  ami                         = "ami-0947d2ba12ee1ff75"
  instance_type               = "t3a.medium"
  associate_public_ip_address = "true"
  root_volume_size            = 30
  subnet_ids                  = module.vpc.public-subnet-ids
  vpc_security_group_ids      = [module.sg1.aws_security_group_default]
  user_data                   = file("../../modules/aws-ec2/user-data/user-data.sh")

}

module "sg1" {
  source              = "../../modules/aws-sg-cidr"
  namespace           = "cloudgeeks.ca"
  stage               = "dev"
  name                = "ec2"
  tcp_ports           = "22,80,443"
  cidrs               = ["0.0.0.0/0"]
  security_group_name = "ec2"
  vpc_id              = module.vpc.vpc-id
}

module "sg2" {
  source                  = "../../modules/aws-sg-ref-v2"
  namespace               = "cloudgeeks.ca"
  stage                   = "dev"
  name                    = "ec2-ref"
  tcp_ports               = "22,80,443"
  ref_security_groups_ids = [module.sg1.aws_security_group_default, module.sg1.aws_security_group_default, module.sg1.aws_security_group_default]
  security_group_name     = "ec2-ref"
  vpc_id                  = module.vpc.vpc-id
}


module "ec2-eip" {
  source   = "../../modules/eip/ec2"
  name     = "ec2"
  instance = module.ec2.id[0]
}

module "ec2-keypair" {
  source     = "../../modules/aws-ec2-keypair"
  key-name   = "ec2"
  public-key = file("../../modules/secrets/ec2.pub")
}



