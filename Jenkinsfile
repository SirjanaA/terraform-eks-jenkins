pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')      
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY') 
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git branch: 'staging', url: 'https://github.com/SirjanaA/terraform-eks-jenkins.git'
            }
        }

        stage('Verify AWS connection') {
            steps {
                sh 'aws sts get-caller-identity'
            }

        }
    }

    post {
        always {
            cleanWs()
        }
    }  
}    