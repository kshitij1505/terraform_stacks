output "s3_buckcet_name" {
  value = aws_s3_bucket.my_bucket.id
}
//output can be taken out of the module for the purpose