/*variables take input from various method, common use can be through cicd pipelines with the help of environment
variable with the variables starting with TF_VAR_ */
/* Point to note when installing a module input variable are expected to be populated in calling module
we can have validation blocks, sensistive etc for variables 
*/

variable "vpc_id" {
  type = string
}

variable "s3_prefix" {
  type = string
}

variable "dynamo_db_name" {
  type = string
}

variable "user" {
  type    = string
  default = "kshitijm"
}

variable "myrepo" {
  type    = string
  default = "terraform_stacks"
}
/*
variable "subnets"{
    type= list(string)
    description = "This is a list of subnets "
}*/