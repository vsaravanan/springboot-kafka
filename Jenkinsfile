#!/usr/bin/env groovy

node {
  @Library('pipeline-library') _
  def jenkinsRoot = "${JENKINS_HOME}/workspace"
  def appVer = ''
  def lastCommitMessage = ''

  environment {
    colordust = credentials('colordust')

  }

  try {
    stage('Clean') {
      clean()
    }

    stage('Environment') {
      envi()
      echo "test page 1 : https://saravanjs.com:4001/statichtmls "
      echo "test page 2 : https://saravanjs.com:8001/ "
    }

    stage('Checkout') {

      (appVer, lastCommitMessage) = checkoutscm();
    }

    stage('Build') {
//      sh "mvn clean package install -T 1C"
      mvnbuild()
    }


    stage('SonarQube') {
//      try
//      {
//        def scannerHome = tool 'sonar-scanner';
//        withSonarQubeEnv() {
//          def sonarServerReachable = sh(script: 'curl -s -o /dev/null -w "%{http_code}" http://sjsdb:9000', returnStatus: true) == 200
//          if (sonarServerReachable) {
//            echo "SonarQube server is running."
//            sh "${scannerHome}/bin/sonar-scanner"
//            sonarqube()
//          } else {
//            echo 'SonarQube server is down. Continuing without analysis.'
//          }
//        }
//      } catch (Exception e) {
//        echo "SonarQube analysis failed: ${e.message}. Continuing the job."
//      }
    }

    stage('Package') {
      //sh "cd ${jenkinsRoot}; pwd; tar -czf ${WORKSPACE}.tar.gz ${JOB_NAME}"
      tarpack()
    }

    stage('Deploy') {

      deploy()
    }

    stage('Archive') {
//      sshagent(['ecdsa']) {
//        sh "ssh viswar@sjsapp bash /data/scripts/archive.sh ${JOB_NAME} ${appVer} --error"
//      }
      archive(appVer)
    }

    stage('Install') {
       install()
    }

    stage('Email') {
      email.success( appVer, lastCommitMessage)
    }
  } catch (Exception error) {
    email.failed( appVer, lastCommitMessage)
  }

}
