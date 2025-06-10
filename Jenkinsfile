pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
    }
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Choose Terraform action')
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
        stage('Plan Infrastructure') {
            steps {
                dir('terraform') {
                    sh "terraform plan -out=tfplan ${params.ACTION == 'destroy' ? '-destroy' : ''}"
                }
                input(message: "Do you want to proceed with ${params.ACTION}?", ok: "Proceed") // Input within steps
            }
        }

        stage('Apply or Destroy Infrastructure') {
            steps {
                script {  // Script block for conditional logic
                    dir('terraform') {
                        if (params.ACTION == 'apply') {
                            sh 'terraform apply -auto-approve tfplan'
                        } else {
                            sh 'terraform destroy'
                        }
                    }
                } // End of script block
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
