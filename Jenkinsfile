#!/usr/bin/env groovy

def REGISTRY = 'https://192.168.56.101:5000',
    IMAGE = 'shb-ui'

docker.withRegistry($REGISTRY, 'docker-registry-credentials-id') {
    def app, version

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        sh './build-docker-image.sh'
        app = docker.image('$REGISTRY/$IMAGE:latest')
    }

    stage('Test image') {
        // Todo
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
         steps{
            app.inside {
                version = '1.0.0' //sh(returnStdout: true, script: 'node -e "console.log(require('$APP_HOME/package.json').version);"').trim()
            }
         }
        /* Push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        sh 'echo version: $version'
        app.push("${env.BUILD_NUMBER}")
        app.push("latest")
    }
}
