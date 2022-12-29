pipeline{
    agent any
        stages{
            stage("scm"){
                steps{
                git branch: 'main', url: 'https://github.com/srinivas363/test.git'
                    }
                         }
            stage("imagebuild"){
                steps{
                sh '''cd microservices
                docker build -t docker.io/srinivas363/image1:v0 .
                pwd
                 '''
        }
}
            stage("imagepush"){
                steps{
                withCredentials([usernamePassword(credentialsId: 'registry', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
				sh '''
                docker push docker.io/srinivas363/image1:v0'''
												}
					}
}
}
}
