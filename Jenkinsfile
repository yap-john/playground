pipeline {
    agent any

    stages {
        stage('run playbook'){
            steps {
                ansiblePlaybook inventory: 'inventory', playbook: 'sample-playbook.yml'
            }
        }
    }
}
