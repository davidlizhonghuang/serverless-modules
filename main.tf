provider "aws" {
    region = "us-west-2"
}

module "s3" {
    source = "github.com/davidlizhonghuang/serverless-modules//modules/s3?ref=main"
    bucket_name = "lizbuket1"
}

module "lambda" {
    source = "github.com/davidlizhonghuang/serverless-modules//modules/lambda?ref=main"
    function_name = "helllambda"
    zip_file = "${path.module}/lambda.zip"
    dynamodb_table_arn  = module.dynamodb.table_arn
}

module "api_gateway" {
    source ="github.com/davidlizhonghuang/serverless-modules//modules/api_gateway?ref=main"
    lambda_arn   = module.lambda.lambda_arn
    lambda_name  = module.lambda.lambda_name
}

module "cognito" {
  source = "github.com/davidlizhonghuang/serverless-modules//modules/cognito?ref=main"
  callback_url = "https://jwt.io"
}

module "dynamodb" {
  source     = "github.com/davidlizhonghuang/serverless-modules//modules/dynamodb?ref=main"
  table_name = "UserData"
}