pipeline{
	agent any
	triggers {
  	pollSCM '* * * * *'
		}

		stages{
		stage("one"){
			steps{
			sh 'echo hi hello'
			}
			}
		stage("two"){
			steps{
			sh 'echo iam good how are you'
			}
			}
			}
			}
