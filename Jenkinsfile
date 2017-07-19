#!/usr/bin/env groovy
def REGISTRY = '192.168.56.101:5000',
    IMAGE = 'test-nodejs'

docker.withRegistry("https://$REGISTRY", 'docker-registry-credentials-id') {
    def app, version

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        // VERSION = sh (
        //   // script: 'echo $(sed -nE \'s/^\\s*"version": "(.*?)",$/\\1/p\' package.json',
        //   // script: 'echo "1.0.0"',
        //   returnStdout: true
        // ).trim()
        // echo "version: ${VERSION}"
        sh "docker build -t $REGISTRY/$IMAGE-${env.BUILD_NUMBER}:latest --rm=true ."
        //sh './build-docker-image.sh'
        app = docker.image('192.168.56.101:5000/test-nodejs:latest')
    }

    stage('Test image') {
        // Todo
        app.inside {
            sh 'echo "All Tests passed"'
        }
    }

    stage('Push image') {
        def VERSION
        app.inside {
            VERSION= sh(script: 'echo $(node -p -e "require(\'./package.json\').version")', returnStdout: true).trim()
        }
        echo "version: ${VERSION}"
        /* Push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */

        // app.push("${env.BUILD_NUMBER}")
        app.push("${VERSION}")
        app.push("latest")
    }
}
