#!/usr/bin/env groovy

node {
  @Library('pipeline-library') _

  def javaHome = env.JAVA_HOME
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
      sh "mvn clean package install -T 1C"
    }

    stage('SonarQube') {
      withSonarQubeEnv() {
        sh "mvn clean verify sonar:sonar -Dsonar.projectKey=saravanjs-project -Dsonar.projectName='saravanjs-project'"
      }
    }

    stage('Package') {
      sh "cd ${jenkinsRoot}; pwd; tar -czf ${WORKSPACE}.tar.gz ${JOB_NAME}"
    }

    stage('Deploy') {
      sshagent(['ecdsa']) {
        sh 'scp ${WORKSPACE}.tar.gz viswar@sjsapp:/data/tmp'
      }
    }

    stage('Archive') {
      sshagent(['ecdsa']) {
        sh "ssh viswar@sjsapp bash /data/scripts/archive.sh ${JOB_NAME} ${appVer} --error"
      }
    }

    stage('Install') {
      withCredentials([string(credentialsId: 'colordust', variable: 'colordust')]) {
        sshagent(['ecdsa']) {
          sh 'ssh viswar@sjsapp bash /data/scripts/install.sh ${JOB_NAME} ${colordust} --error'
        }
      }
    }

    stage('Email') {
      email.success( appVer, lastCommitMessage)
    }
  } catch (Exception error) {
    email.failed( appVer, lastCommitMessage)
  }

}
