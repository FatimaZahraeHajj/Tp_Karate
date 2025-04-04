pipeline {
    agent any

    environment {
        TOKEN_FILE = 'xray_token.txt'
        XRAY_ISSUE_KEY = 'POEI20252-625'
    }

    stages {
        stage('Get Xray Token') {
            steps {
                withCredentials([
                    string(credentialsId: 'XRAY_CLIENT_ID', variable: 'XRAY_ID'),
                    string(credentialsId: 'XRAY_CLIENT_SECRET', variable: 'XRAY_SECRET')
                ]) {
                    bat """
                        curl -X POST https://xray.cloud.getxray.app/api/v2/authenticate ^
                        -H "Content-Type: application/json" ^
                        -d "{\\\"client_id\\\": \\\"%XRAY_ID%\\\", \\\"client_secret\\\": \\\"%XRAY_SECRET%\\\"}" ^
                        -o %TOKEN_FILE%
                    """
                }
            }
        }

        stage('Download Feature Files from Xray') {
            steps {
                script {
                    def token = readFile("${env.TOKEN_FILE}").trim().replaceAll('"', '')
                    echo "Token chargé pour export : OK"

                    bat """
                        curl -X GET "https://xray.cloud.getxray.app/api/v2/export/cucumber?keys=${env.XRAY_ISSUE_KEY}" ^
                        -H "Authorization: Bearer ${token}" ^
                        -H "Accept: application/zip" ^
                        --output features.zip
                    """

                    bat 'powershell -Command "Expand-Archive -Path features.zip -DestinationPath src/test/resources/features -Force"'
                    bat 'dir src\\test\\resources\\features'
                }
            }
        }

        stage('Run Karate Tests') {
            steps {
                bat 'mvn test'
            }
        }
    }

    post {
        always {
            junit 'target/surefire-reports/*.xml'
        }
    }
}
