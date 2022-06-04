# Common Variables
variable "aws_region" {
  type        = string
}
#
#variable "log_level" {
#  type        = string
#}

variable "image_tag" {
  type 			= string
  description 	= "Given image tag for the current deployment."
}
#
#variable "environment" {
#  type        = string
#  description = "Unique environment name for the setup. Alphanumeric characters."
#}

variable "vpc_name" {
  type 	= string
  description = "Name of the containing VPC. Required."
}

variable "public_subnets" {
  type    = list(string)
  default = []
}

variable "account_id" {
  type = string
  description = "ID of the AWS account"
}

variable "service_name" {
  type        = string
  description = "the name of the service."
}

#variable "health_check_path" {
#	type = string
#	description = "health tools health check"
#}
#
## Domain and Routing
#variable "certificate_arn" {
#  type = string
#}
#
#variable "domain_name" {
#  type = string
#}
#
#variable "zone_id" {
#  type = string
#}
#
#variable "log_router_name" {
#  type    = string
#  default = "log-router"
#}
#

