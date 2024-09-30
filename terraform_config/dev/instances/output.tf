# Add output variables
output "eip" {
  value = aws_eip.CLO835_week_04_Assignment_01_static_eip.public_ip
}