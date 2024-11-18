pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/Nimaa31/jenkins.git'
        GIT_BRANCH = 'master'  // Branche à utiliser dans Git
        DOCKER_IMAGE = 'amin/jenkins' // Nom de l'image Docker (ajoutez votre Docker Hub utilisateur ici)
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Authentification Docker Hub avec les credentials
                    withCredentials([usernamePassword(credentialsId: '5eed437d-b79c-4b5c-acd9-933c8775bc55', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh '''
                        docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}  // Login à Docker Hub
                        docker build -t ${DOCKER_IMAGE}:latest .  // Build de l'image Docker
                        docker push ${DOCKER_IMAGE}:latest  // Push de l'image sur Docker Hub
                        '''
                    }
                }
            }
        }

        stage('Push to GitHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'amin', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_TOKEN')]) {
                        sh '''
                        git config --global user.name "Nimaa31"
                        git config --global user.email "amin.eddine31@icloud.com"
                        git add .
                        git commit -m "Automated commit from Jenkins"
                        git push https://${GIT_USER}:${GIT_TOKEN}@github.com/Nimaa31/jenkins.git
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
