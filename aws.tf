terraform {

  /* you can use a remote backend / or standard backend like s3 
    if using s3 enable versioning and encryption for storing the tf states"
    */

}


provider "aws" {
  profile                 = "saml"
  region                  = "us-east-2"
  shared_credentials_file = "C:\\Users\\smishra\\.aws\\credentials"
}
/* we have a lock file for the state as well*/
