#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME

    def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH
    env.BRANCH_NAME = "main"
    environment {
        SFDC_BRANCH = 'main'
    }
    env.PATH = "C:\\Program Files\\sf\\bin;${env.PATH}"

    bat "sfdx --version"


    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY

    
    //def toolbelt = tool 'toolbelt'
stages{  
  stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }
         withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
  
  stage('Authenticate') {
            if (isUnix()) {
                rc = sh returnStatus: true, script: "sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            }else{
                 rc = bat returnStatus: true, script: "sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
            }
            if (rc != 0) { error 'hub org authorization failed' }

		println rc
    }
      println 'start identifying delta'
  stage('Identify Delta') {
            steps {
                script {
                    // Identify changed files using Git
                    def changedFiles = sh(returnStdout: true, script: "git diff --name-only origin/${SFDC_BRANCH}...HEAD").trim()
                    env.CHANGED_FILES = changedFiles
                }
            }
        }		
		
	    // Identify changed files using Git
                def changedFiles = sh(returnStdout: true, script: "git diff --name-only main...HEAD").trim()
	
	///////paste
	}
    }
}

