/*

Backend are the place where the .tfstate or the state file is stored 
it also defines where and how our code is executed 
*/
terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.20.1"
    }
  }
  backend "s3" {
    bucket  = "confidentiality-resource-20220616064653390900000001"
    key     = "state/terraform.tfstate" 
    region  = "us-east-2"
    profile = "saml"
    # Note this entire bucket is encrypted, object level encryption is not needed.
  }
}
//trying to deploy the standard backed s3 in the same tf


//Standard backend s3,etc :can only store states cannot preform terraform operations
//Enhanced backend : local,remote can perform terraform operation remote is terraform cloud hence can run

// We can use cross reference stacks as below
//using the terraform_remote_state we can only get the output variables of the root module if we want submodule
//we will have to allow pass through for that seperately  using the latest state snapshot from teh remote backend

data "terraform_remote_state" "main" {
  backend = "s3" //can be remote or local or s3 etc we have to specify config

  config = {
    bucket  = "whatever-confidentiality-resource-20220616064653390900000001"
    key     = "repo/main.tfstate"
    region  = var.aws_region
    profile = var.aws_profile
  }

  workspace = terraform.workspace
}

//below is how to specify pass through to sub module
module "child" {
  source    = "./module-aws-api"
  bucket_id = aws_s3_bucket.my_bucket.id //here the sub module is called with the input variables 

}

output "value" {
  value = module.child.s3  //then we can output the modules output through the root module

}

// ${path.module} can be used for path interpolation cwd
//when we are using remote backend we will have to use terraform workspace


//so for the alternative we should use data source to resources  (NOT terraform_remote_state datasources)

data "aws_s3_bucket" "selected"{
    bucket = "bucket.test.com"
}

// if the versioning is enabled we have the new file for each of the tf operations 
//for ex. apply or destroy 
