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
  } /*
    backend "s3" {
        bucket         = "confidentiality-resource-20220616064653390900000001"
        key            = "state/terraform.tfstate" //note how string interpolation can be used 
        region         = "us-east-2"
        profile         = "saml"
    # Note this entire bucket is encrypted, object level encryption is not needed.
    }*/
}
//trying to deploy the standard backed s3 in the same tf


