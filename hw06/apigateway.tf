resource "aws_api_gateway_rest_api" "api_gateway_rest_api" {
  name = "api-gateway"
}

resource "aws_api_gateway_resource" "api_gateway_resource" {
  path_part   = "weather"
  parent_id   = aws_api_gateway_rest_api.api_gateway_rest_api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest_api.id
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_rest_api.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway_rest_api.id
  resource_id             = aws_api_gateway_resource.api_gateway_resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.proxy_lambda.invoke_arn
}
