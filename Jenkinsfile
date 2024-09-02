pipeline {
    agent any

    environment {
        // Set environment variables if needed
    }

    stages {
        stage('Checkout Pipeline Script') {
            steps {
                // Checkout the Jenkins pipeline script
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],
                          userRemoteConfigs: [[url: 'https://github.com/yap-john/playground.git']]])
            }
        }

        stage('Checkout Ansible Playbook') {
            steps {
                // Checkout the Ansible playbook repository
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],
                          userRemoteConfigs: [[url: 'https://github.com/yap-john/playground.git']]])
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
