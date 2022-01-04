output "subnet_cidrs_public" {
  description = "Public subnet EKS control plane."
  value       = aws_subnet.public_subnet.*.cidr_block
}

output "subnet_cidrs_private" {
  description = "Private subnet EKS control plane."
  value       = aws_subnet.private_subnet.*.cidr_block
}