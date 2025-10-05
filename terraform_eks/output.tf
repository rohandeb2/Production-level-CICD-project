output "cluster_id" {
	value = aws_eks_cluster.rohandevops.id
}

output "node_group_id" {
	value = aws_eks_node_group.rohandevops.id
}

output "vpc_id" {
	value = aws_vpc.rohandevops_vpc.id
}

output "subnet_ids" {
	value = aws_subnet.rohandevops_subnet[*].id
}
