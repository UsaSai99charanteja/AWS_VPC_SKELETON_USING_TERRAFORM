output "vpc_id" {
  value = aws_vpc.eks_vpc.id  
}

output "public1" {
  value = aws_subnet.pub1.id
}

output "public2" {
  value = aws_subnet.pub2.id
}

output "private1" {
  value = aws_subnet.priv1.id
}

output "private2" {
  value = aws_subnet.priv2.id
}

output "IGW" {
  value = aws_internet_gateway.igw.id  
}

output "region" {
  value = var.region
}

output "Project-Name" {
  value = var.project_name
}