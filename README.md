# DevOps - Terraform, EKS, and Jenkins Deployment

## Overview
This repository demonstrates the deployment of an EKS cluster using Terraform and Jenkins.

- New EC2 instance was created for this project in eruser102 AWS account:
    - Instance Name: kub-jenkins
    - Instance Type: Ubuntu t2.medium
    - Region: us-east-1
    - Existing keypair and security group were used.
    - Installed seperate Jenkins server as the existing server was running very slow/
    - Server port opened to 8080, 22, 443, 80 and 8082 enabled.
    - IAM role attached to the instance. 

* Code is managed in a GitHub repository: https://github.com/SirjanaA/terraform-eks-jenkins.git with main, dev, and staging branches. The staging branch is primarily used for pipeline testing, while actual development occurs on the dev branch, which is then merged into main.
* All changes are currently in the 'dev' branch. If the pipeline needs to be run from 'main,' please switch to the 'main' branch before execution.
* git fetch --all (command to see all the branchesgit )

## Prerequisites
* The 'installer.sh' file lists the necessary installations. For this project, these were installed manually after EC2 instance creation. This script could be incorporated into the instance's user data for automated installation.
*  Access to the Jenkins server is through public ip of kub-jenkins. (Admin credentials can be provided)


## Project Structure and Terraform Configuration
The Terraform configuration files are located in the terraform-eks-jenkins/terraform directory.

* provider.tf: Defines the AWS provider and includes local variables for IP addresses, region (us-east-1), cluster name (jenkins-cluster), VPC CIDR range, availability zones, and private and public subnet configurations. Inspired by: https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/examples/complete/main.tf

* eks.tf: Configures the EKS cluster, including managed node groups using SPOT instances. Adapted from: https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/modules/eks-managed-node-group/main.tf This configuration has been streamlined for the specific requirements of this project.

* vpc.tf: Defines the VPC configuration. Leverages modules from: https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/examples/complete/main.tf


# Deploying the EKS Cluster

## Using Terraform
- Clone the repository: git clone https://github.com/SirjanaA/terraform-eks-jenkins.git (either on your local machine or the EC2 instance).
- Navigate to the Terraform directory: cd ~/terraform-eks-jenkins/terraform
- Initialize Terraform: terraform init
- Validate the configuration: terraform validate
- Review the planned changes: terraform plan
- Apply the configuration: terraform apply (and confirm with 'yes')
- Cluster creation takes 15-20 minutes.
- To destroy the infrastructure: terraform destroy (and confirm)

## Using Jenkins
- Log in to Jenkins (AWS credentials are configured as secret text in Jenkins Global credentials).
- Create a new pipeline project with Github SCM.
- Configure the pipeline to use the GitHub repository: https://github.com/SirjanaA/terraform-eks-jenkins.git, select branch */dev. and save.
- Build with parameter will be trigger after the first run, with the desired action ('apply' to create, 'destroy' to delete).
- Monitor the build progress via the console output. During the 'apply' process, manual confirmation ('proceed') is required.
- Cluster creation/destruction takes approximately 15-20 minutes.
- Verify the cluster status in the AWS console.

## Interacting with the EKS cluster
After the cluster is created, you can interact with it using kubectl.

- Update your kubeconfig: aws eks update-kubeconfig --region us-east-1 --name jenkins-cluster
- View pods: kubectl get pods (initially, no pods should be running)

## Creating a Pod (incomplete)
- Deploy an Nginx pod: kubectl run nginx --image=nginx
- Verify pod creation: kubectl get pods

## Destroying the infrastructure
- Use the Jenkins pipeline with the 'destroy' action to dismantle the EKS cluster and associated resources. This process can take 15-20 minutes.
