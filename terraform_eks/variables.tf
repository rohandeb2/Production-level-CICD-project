variable "ssh_key_name" {
	description = "The name of the SSH Key pair to use for instance"
	type = string
	default = "20 dollar ec2 instance"     # if you have an existing key pair, use the previous one, or create a new one by creating a new EC2 instance 
											# how to check if already exists or not aws command --> aws ec2 describe-key-pairs --region us-east-1

}
