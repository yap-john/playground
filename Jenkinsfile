pipeline {
    agent any

    environment {
        // Set environment variables if needed
    }

    stages {
        stage('git clone'){
            steps {
                sh "git clone https://github.com/yap-john/playground.git"
            }
        }
        
        stage('Run Ansible Playbook') {
            steps {
                script {
                    // Run the Ansible playbook
                    sh '''
                    ansible-playbook sample-playbook.yml -i inventory
                    '''
                }
            }
        }
    }
    
    post {
        always {
            // Cleanup or notifications
        }
    }
}
