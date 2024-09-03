pipeline {
    agent any

    stages {
        
        stage('checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/yap-john/playground']])
            }
        }
        stage('run playbook'){
            steps {
                ansiblePlaybook inventory: 'inventory', playbook: 'sample-playbook.yml'
            }
        }
    }
}
