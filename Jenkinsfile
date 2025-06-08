pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Choose Terraform action')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')      
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY') 
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git branch: 'dev', url: 'https://github.com/SirjanaA/terraform-eks-jenkins.git'
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

        stage('Plan Infrastructure') {
            steps {
                dir('terraform') {
                    script {
                        if (params.ACTION == 'apply') {
                            sh 'terraform plan -out=tfplan'
                        } else {
                            sh 'terraform plan -destroy -out=tfplan'
                        }
                    }
                }
                input(message: "Do you want to proceed with ${params.ACTION}?", ok: "Proceed")
            }
        }

        stage('Apply or Destroy Infrastructure') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve tfplan'
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
