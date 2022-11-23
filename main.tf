data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["979382823631"] # Bitnami
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [module.web-sg.security_group_id]

  tags = {
    Name = "HelloWorld"
  }
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "dev-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "web-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.16.2"
  name = "web new"

  vpc_id = module.vpc.public_subnets[0]

  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"] 

  egress_rules        = [ "all", "all"]
  egress_cidr_blocks  = ["0.0.0.0/0"] 
} 

