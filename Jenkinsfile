pipeline {
    agent any

    tools {
        jdk 'jdk'
        maven 'maven'
    }

    environment {
        SCANNER_HOME = tool 'sonarqube'
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'main', credentialsId: 'git-cred', url: 'https://github.com/rohandeb2/Production-level-CICD-project.git'
            }
        }

        stage('Compile') {
            steps {
                sh "mvn compile"
            }
        }
        
        stage('Test') {
            steps {
                sh "mvn test"
            }
        }

        stage('File System Scan') {
            steps {
                sh "trivy fs --format table -o trivy-fs-report.html ."
            }
        }

        stage('Sonarqube Analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh """
                        $SCANNER_HOME/bin/sonar-scanner \
                        -Dsonar.projectKey='production-level-cicd-pipeline-project' \
                        -Dsonar.projectName='Production Level CICD Pipeline Project' \
                        -Dsonar.java.binaries=target
                    """
                }
            }
        }


        stage('Build') {
            steps {
                sh "mvn package"
            }
        }

        stage('Publish to Nexus') {
            steps {
                withMaven(globalMavenSettingsConfig: 'mavenwa', jdk: 'jdk', maven: 'maven', traceability: true) {
                    sh "mvn deploy"
                }
            }
        }

        stage('Build & tag docker image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerHubCreds', toolName: 'docker') {
                        sh "docker build -t rohan700/bloggingapp:latest ."
                    }
                }
            }
        }

        stage('Docker Image scan') {
            steps {
                sh "trivy image --timeout 15m --format table -o trivy-image-report.html rohan700/bloggingapp:latest"
            }
        }

        stage('Push to docker') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerHubCreds', toolName: 'docker') {
                        sh "docker push rohan700/bloggingapp:latest"
                    }
                }
            }
        }

        stage('Deploy to kubernetes') {
            steps {
                withKubeConfig(
                    caCertificate: '',
                    clusterName: 'Kubernetes',
                    contextName: '',
                    credentialsId: 'k8s-cred',
                    namespace: 'webapps',
                    restrictKubeConfigAccess: false,
                    serverUrl: '<eks api access point url>'
                ) {
                    sh "kubectl apply -f k8s/deployment-service.yml"
                }
            }
        }

        stage('Verify the deployment') {
            steps {
                withKubeConfig(
                    caCertificate: '',
                    clusterName: 'Kubernetes',
                    contextName: '',
                    credentialsId: 'k8s-cred',
                    namespace: 'webapps',
                    restrictKubeConfigAccess: false,
                    serverUrl: '<eks api access point url>'
                    #serverUrl: 'https://DE2E541B087E6D31F32168E4FD7D1282.gr7.us-east-1.eks.amazonaws.com'
                ) {
                    sh "kubectl get pods -n webapps"
                    sh "kubectl get svc -n webapps"
                }
            }
        }
    }

post {
        success {
            script {
                emailext (
                    from: '<your-email-address>',
                    to: '<your-email-address>',
                    subject: 'Build Success: Demo CICD Pipeline',
                    body: 'Build success for demo CICD pipeline'
                )
            }
        }

        failure {
            script {
                emailext (
                    from: '<your-email-address>',
                    to: '<your-email-address>',
                    subject: 'Build Failure: Demo CICD Pipeline',
                    body: 'Build failure for demo CICD pipeline'
                )
            }
        }
    }
}
