pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Choose action')
    }
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
        TF_ACTION = params.ACTION // Assign the parameter value to TF_ACTION
    }
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scmGit(branches: [[name: '*/dev']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/SirjanaA/terraform-eks-jenkins.git']])
            }
        }
        stage('Initializing Terraform') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage('Validating Terraform') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }
        stage('Previewing the infrastructure') {
            steps {
                dir('terraform') {
                    sh 'terraform plan -out=tfplan' // Save the plan
                }
                input(message: "Approve?", ok: "proceed")
            }
        }
        stage('Applying Terraform or Destroying Infrastructure') { // Clearer stage name
            steps {
                dir('terraform') {
                    sh "terraform ${params.ACTION} tfplan" // Use saved plan and parameter
                }
            }
        }
    }
    post {
        always {
            // Clean up the tfplan file (optional)
            cleanWs()
        }
    }
}