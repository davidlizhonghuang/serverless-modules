variable "function_name" {}
variable "zip_file" {}
variable "dynamodb_table_arn" {}

environment {
  variables = {
    DYNAMODB_TABLE = var.dynamodb_table_name
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "basic_exec" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  handler       = "lambda_handler.handler"
  runtime       = "python3.12"
  role          = aws_iam_role.lambda_role.arn
  filename         = var.zip_file
  source_code_hash = filebase64sha256(var.zip_file)
}

resource "aws_iam_role_policy" "dynamodb_access" {
  name = "LambdaDynamoDBAccess"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["dynamodb:PutItem", "dynamodb:GetItem", "dynamodb:UpdateItem", "dynamodb:DeleteItem", "dynamodb:Scan"],
        Effect   = "Allow",
        Resource = var.dynamodb_table_arn
      }
    ]
  })
}



output "lambda_arn" {
  value = aws_lambda_function.this.arn
}

output "lambda_name" {
  value = aws_lambda_function.this.function_name
}
