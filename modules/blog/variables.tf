variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t2.micro"
}

variable "ima_filter" {
  description = "Name filter and owner for AMI"

  type = object ({
    name  = string
    owner = string
  })

  default = {
    name  = "bitnami-tomcat-*-x86_64-hvm-ebs-nami"
    owner = "979382823631" # Bitnami
  }
}

variable "asg_min_size"{
  description = "Minimum number of instances in the ASG"
  default = 1
}

variable "asg_max_size"{
  description = "Maximum number of instances in the ASG"
  default = 2
}

variable "environment"{
  description = "Development Enviroment"

  type = object ({
    name = string
    network_prefix = string
  })
  
  default = {
    name = "dev"
    network_prefix = "10.0"
  }
}




