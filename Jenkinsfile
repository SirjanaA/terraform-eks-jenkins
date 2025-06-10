pipeline {
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
    }

   pipeline {
    agent any
    
    stages {
        stage ("checkout from GIT") {
            steps {
                git branch: 'dev', url: 'https://github.com/SirjanaA/terraform-eks-jenkins.git'
               
            }
        }
        stage ("terraform init") {
            steps {
                sh 'terraform init'
            }
        }
        stage ("terraform fmt") {
            steps {
                sh 'terraform fmt'
            }
        }
        stage ("terraform validate") {
            steps {
                sh 'terraform validate'
            }
        }
        stage ("terrafrom plan") {
            steps {
                sh 'terraform plan'
            }
        }
        stage ("terraform apply") {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
     }
   }
}