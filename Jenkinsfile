                   pipeline {
    agent any

    environment {
        BROWSERSTACK_USERNAME = credentials('browserstack-username')
        BROWSERSTACK_ACCESS_KEY = credentials('browserstack-access-key')
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from repository...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing required dependencies...'
                sh '''
                    pip install --upgrade pip
                    pip install robotframework
                    pip install robotframework-seleniumlibrary
                    pip install selenium
                '''
            }
        }

        stage('Update BrowserStack Credentials') {
            steps {
                echo 'Configuring BrowserStack credentials...'
                sh '''
                    sed -i "s/your_username/${BROWSERSTACK_USERNAME}/" browserstack_config.py
                    sed -i "s/your_access_key/${BROWSERSTACK_ACCESS_KEY}/" browserstack_config.py
                '''
            }
        }

        stage('Run Tests on Chrome') {
            steps {
                echo 'Running tests on Chrome browser...'
                sh '''
                    robot --outputdir results/chrome \
                          --include chrome \
                          --name "Chrome Tests" \
                          tests/test_all_browsers.robot
                '''
            }
        }

        stage('Run Tests on Firefox') {
            steps {
                echo 'Running tests on Firefox browser...'
                sh '''
                    robot --outputdir results/firefox \
                          --include firefox \
                          --name "Firefox Tests" \
                          tests/test_all_browsers.robot
                '''
            }
        }

        stage('Run Tests on Safari') {
            steps {
                echo 'Running tests on Safari browser...'
                sh '''
                    robot --outputdir results/safari \
                          --include safari \
                          --name "Safari Tests" \
                          tests/test_all_browsers.robot
                '''
            }
        }

        stage('Merge Results') {
            steps {
                echo 'Merging test results...'
                sh '''
                    rebot --outputdir results/final \
                          --name "Cross-Browser Test Results" \
                          results/chrome/output.xml \
                          results/firefox/output.xml \
                          results/safari/output.xml
                '''
            }
        }
    }

    post {
        always {
            echo 'Publishing test results...'
            robot outputPath: 'results/final',
                  outputFileName: 'output.xml',
                  reportFileName: 'report.html',
                  logFileName: 'log.html',
                  disableArchiveOutput: false,
                  passThreshold: 80.0,
                  unstableThreshold: 70.0

            archiveArtifacts artifacts: 'results/**/*', allowEmptyArchive: true
        }
        success {
            echo 'Tests completed successfully!'
        }
        failure {
            echo 'Tests failed. Check the logs for details.'
        }
    }
}