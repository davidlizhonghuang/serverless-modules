provider "aws" {
    region = "us-west-2"
}

module "s3" {
    source = "./modules/s3"
    bucket_name = "lizbuket1"
}

module "lambda" {
    source = "./modules/lambda"
    function_name = "helllambda"
    zip_file = "${path.module}/lambda.zip"
}

module "api_gateway" {
    source ="./modules/api_gateway"
    lambda_arn   = module.lambda.lambda_arn
    lambda_name  = module.lambda.lambda_name
}

module "cognito" {
  source = "./modules/cognito"
  callback_url = "https://jwt.io"
}
