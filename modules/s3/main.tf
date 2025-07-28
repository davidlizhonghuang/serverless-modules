variable "bucket_name"{}
# variable

resource "aws_s3_bucket" "this"{
    bucket=var.bucket_name
}
# create bucket function_name

output "bucket_name"{
    value = aws_s3_bucket.this.id
}
# output name

