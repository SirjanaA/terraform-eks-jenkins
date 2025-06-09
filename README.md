# DevOps - Terraform EKS and Jenkins

## Information
This repository utilises Terraform, EKS and Jenkins.

- New EC2 instance was created for this project in eruser102 AWS account:
    - Instance Name: kub-jenkins
    - Instance Type: Ubuntu t2.medium
    - Region: us-east-1
    - Existing keypair and security group were used. 
    - Existing access key and secrets key used from eruser102.
    - Existing Github access token in Jenkins.

- Remote SSH into VScode and all the files were uploaded in Github repo https://github.com/SirjanaA/terraform-eks-jenkins.git 
- 3 branches in the repo: main, dev and staging.
- Staging branch is for testing and practicing groovy scripts for Jenkins before adding to dev. 
- Changes are updated in 'dev' branch then merged to 'main' branch.

## Git commands
- git checkout -b <branch name> (new branch)
- git add .
- git status
- git commit -m "your message for change"
- git push --set-upstream origin staging
- or git push for an existing branch

## Prerequisites
* Necessary installation are listed under installer.sh file.
* For this capstone I just installed it manually after creating the EC2 instance. It can be easily run by adding the script in user data when creating the instance.
* Same Jenkins account is used to run Jenkinsfile from this url: https://github.com/SirjanaA/Jenkins-cap.git

## IAC
- cd terraform-eks-jenkins/terraform 
- There are 3 files: eks.tf, provider.tf and vpc.tf
- cat provider.tf to see the file
- Provider details is provided along with locals variable for IP addresses
    * locals included the region, name of the cluster, vpc cidr range, azs, private and public submets
    * source code: https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/examples/complete/main.tf
- eks.tf script derived from the source code: https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/modules/eks-managed-node-group/main.tf
    - only used the required scripts for this project.
    - cpacity type is SPOT instance. 
- vpc.tf script are used from terraform vpc modules: https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/examples/complete/main.tf

## EKS cluster using Jenkins
- Login to Jenkins accounts, AWS credentials already configured in the Jenkins Global credentials as secret text.
- Create new item using pipeline save then configure.

### First test

- Check done in staging 
- Firstly, pipeline script I used just the environemt variable and first stage to checkout SCM - source code management. 
- Create an item using pipeline then save to configure, selected just using pipeline.
- Opened pipeline syntax in new window then selected 'checkout: check out from version control under sample steps.
- SCM -> Git then url: https://github.com/SirjanaA/terraform-eks-jenkins.git
- Credentials as none as its a public repo.
- Branch */dev and everything as default and generated pipeline script: 
    "stages {
        stage('Checkout SCM') {
            steps {
                checkout scmGit(branches: [[name: '*/dev']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/SirjanaA/terraform-eks-jenkins.git']])
            }
        }
    }"
- Build failed

