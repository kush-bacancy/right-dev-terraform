variable "prefix" {
  description = "Prefix to be added to resource names"
  type        = string
  default     = "right-dev"
}

variable "bucket_names" {
  type    = list(string)
  default = ["right-dev-bucket1", "right-dev-bucket2", "right-dev-bucket3"] # Update with your desired bucket names
}

variable "ami"{
  type = string
  default = "ami-083654bd07b5da81d"
}
variable "keyname"{
  default = "Mailbinal"
}
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "default region"
}

variable "vpc_cidr" {
  type        = string
  default     = "172.16.0.0/16"
  description = "default vpc_cidr_block"
}

variable "pub_sub1_cidr_block"{
  type        = string
  default     = "172.16.1.0/24"
}

variable "pub_sub2_cidr_block"{
  type        = string
  default     = "172.16.2.0/24"
}
variable "prv_sub1_cidr_block"{
  type        = string
  default     = "172.16.3.0/24"
}
variable "prv_sub2_cidr_block"{
  type        = string
  default     = "172.16.4.0/24"
}

variable "sg_description"{
  type = string
  default = "SG for application load balancer"
}

variable "sg_tagname"{
  type = string
  default = "SG for ALB"
}

variable "sg_ws_description"{
  type = string
  default = "SG for web server"
}

variable "sg_ws_tagname"{
  type = string
  default = "SG for web"
}
