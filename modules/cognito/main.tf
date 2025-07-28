variable "callback_url" {}

resource "aws_cognito_user_pool" "this" {
  name = "serverless-user-pool"
}

resource "aws_cognito_user_pool_client" "client" {
  name                         = "serverless-client"
  user_pool_id                = aws_cognito_user_pool.this.id
  generate_secret             = false
  allowed_oauth_flows         = ["code"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes        = ["openid"]
  callback_urls               = [var.callback_url]
  supported_identity_providers = ["COGNITO"]
}

output "user_pool_id" {
  value = aws_cognito_user_pool.this.id
}

output "client_id" {
  value = aws_cognito_user_pool_client.client.id
}
