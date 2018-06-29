node {

  try {

    deleteDir()

    stage('Checkout') {
      checkout scm
    }

    stage ('Test') {
      sh('mvn clean test')
    }

    stage ('Package') {
      sh('docker build -t jorgealexandro/spring-petclinic:$BUILD_NUMBER -t jorgealexandro/spring-petclinic:latest .')
    }

    stage('Push') {
      withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'DOCKERHUBPASSWORD', usernameVariable: 'DOCKERHUBUSER')]) {
        sh 'docker login -u $DOCKERHUBUSER -p $DOCKERHUBPASSWORD'
        sh 'docker push jorgealexandro/spring-petclinic:$BUILD_NUMBER'
        sh 'docker push jorgealexandro/spring-petclinic:latest'
        sh 'docker logout'
      }
    }

    stage('Update') {
      sh 'sudo salt \'*\' cmd.run \'service docker-petclinic restart\' -v'
    }

  } catch (e) {
    // If there was an exception thrown, the build failed
    currentBuild.result = "FAILED"
    throw e
  } finally {
    junit 'target/surefire-reports/*.xml'
  }
}
