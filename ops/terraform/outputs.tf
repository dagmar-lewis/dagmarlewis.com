output "Public_ip" {
  value = aws_eip.public.public_ip
}

output "api_endpoint" {
  value = "${aws_apigatewayv2_stage.main.invoke_url}/"
}