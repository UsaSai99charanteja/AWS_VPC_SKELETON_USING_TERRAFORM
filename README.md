# AWS_VPC_SKELETON_USING_TERRAFORM
AWS_VPC_SKELETON_USING_TERRAFORM
Image Courtesy: AWS
![image](https://github.com/UsaSai99charanteja/AWS_VPC_SKELETON_USING_TERRAFORM/assets/107063715/3fd4bc74-0e13-4892-ad3a-673414de9c79)

VPC Deployment using Terraform
This repository contains Terraform code to deploy a Virtual Private Cloud (VPC) on AWS. The VPC consists of two private and two public subnets, an Internet Gateway (IGW), and two NAT Gateways. Appropriate route tables are associated with the respective subnets to ensure proper network connectivity.

Prerequisites
Install Terraform: Make sure you have Terraform installed on your local machine. You can download it from the official Terraform website: Terraform Downloads.

AWS Account: You must have an AWS account to deploy the infrastructure.

AWS Credentials: Ensure that you have configured your AWS credentials on your local machine, either using AWS CLI or environment variables.

How to Use
Clone the Repository: Start by cloning this repository to your local machine.

Set Variables: Navigate to the variables.tf file and modify the variables as per your requirements. You can adjust the VPC CIDR blocks, subnet CIDR blocks, region, etc.

Initialize Terraform: Run terraform init in the root directory of the repository to initialize Terraform and download the necessary providers.

Plan Deployment: Execute Terraform plan to review the changes that Terraform will apply to your AWS infrastructure.

Deploy VPC: Once you are satisfied with the plan, run terraform apply and confirm the deployment by typing yes when prompted.

Validate: After the deployment is complete, Terraform will output the VPC ID, Subnet IDs, and other relevant information. You can cross-check the resources created on the AWS Management Console.

Cleanup: To destroy the VPC and all its resources, run Terraform destroy when you are done testing.

Notes
Remember that this code is a basic example to create a VPC with subnets, an IGW, and NAT Gateways. You may need to modify it according to your specific use case.

Make sure to handle your AWS credentials securely and follow the principle of least privilege when assigning IAM roles and permissions.

Be cautious while running the Terraform destroy command, as it will permanently delete all the resources created by Terraform.

For more complex infrastructures, consider using Terraform workspaces, modules, and version control to manage your deployments effectively.

License
This project is licensed under the MIT License - see the LICENSE file for details.







