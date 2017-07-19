#!/usr/bin/env groovy
def REGISTRY = "192.168.56.101:5000";
docker.withRegistry("https://$REGISTRY", 'docker-registry-credentials-id') {
    def app, version

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        sh "docker build -t $REGISTRY/test-nodejs:latest --rm=true ."
        //sh './build-docker-image.sh'
        app = docker.image('192.168.56.101:5000/test-nodejs:latest')
    }

    stage('Test image') {
        // Todo
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {

            app.inside {
                version = sh(returnStdout: true, script: 'node -e "console.log(require(\'./package.json\').version);"').trim()
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
