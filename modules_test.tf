
// We can use a public module verified by Hashi corp as below 
module "ecs_example_complete" {
  source  = "terraform-aws-modules/ecs/aws//examples/complete"
  version = "4.0.2"
}

//We can also provision local or hosted module for organisation level usage
//For configuring the modules we need to pass the input variables in the module block eg. bucket_id in the below 
//example
module "child" {
  source    = "./module-aws-api"        //this is sub module folder (local)
  bucket_id = aws_s3_bucket.confidentiality_bucket.id

}