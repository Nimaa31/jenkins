pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/Nimaa31/jenkins.git'
        GIT_BRANCH = 'master'  // Branche à utiliser dans Git
        COMPOSE_FILE = 'docker-compose.yml'
        DOCKER_IMAGE = '/home/amin/jenkins' // Nom d'image Docker Hub
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
                    withCredentials([usernamePassword(credentialsId: '13a98ec2-40b4-4d73-9982-502893d1739a', usernameVariable: 'amin', passwordVariable: '220702Nimaa-')]) {
                        sh '''
                        docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}  // Login à Docker Hub
                        docker build -t ${DOCKER_IMAGE}:latest .  // Build de l'image Docker
                        docker push ${DOCKER_IMAGE}:latest  // Push de l'image sur Docker Hub
                        '''
                    }
                }
            }
        }

        stage('Docker Compose Up') {
            steps {
                script {
                    sh 'docker-compose -f ${COMPOSE_FILE} up -d'  // Lancement de Docker Compose
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

