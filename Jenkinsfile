pipeline {
    agent any

    environment {
        TOKEN_FILE = 'xray_token.txt'
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
                    bat "type %TOKEN_FILE%" // (facultatif, à enlever si tu veux masquer le token
                }
            }
        }
    }
}
