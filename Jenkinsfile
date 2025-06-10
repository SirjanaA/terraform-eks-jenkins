pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
    }
    stages {
        stage('Checkout SCM') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'dev']], userRemoteConfigs: [[url: 'https://github.com/SirjanaA/terraform-eks-jenkins.git']]])
            }
        }
        stage('Initialize Terraform') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage('Validate Terraform') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }
         stage('Previewing the infrastructure'){
            steps{
                script{
                    dir('terraform'){
                         sh 'terraform plan'
                    }
                    input(message: "Approve?", ok: "proceed")
                }
            }
        }
        stage('Create/Destroy an EKS cluster'){
            steps{
                script{
                    dir('terraform'){
                         sh 'terraform $action --auto-approve'
                    }
                } 
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}