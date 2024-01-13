#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME
    def from_commitId="310a22a0b5e82eed1e446838f34a4e5d79f3040a"
    def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH
    def result = 'null'
    def headCommitId

    env.BRANCH_NAME = "main"
    // Add this line in your Jenkins job script
    env.PATH = "C:\\Program Files\\sf\\bin;${env.PATH}"

    bat "sfdx --version"


    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY

        //def toolbelt = tool 'toolbelt'
	
    
stage('checkout source') {
        
	 checkout scm	
            	    
        }

script {
             from_commitId = readFile 'headcommit_id.txt'.trim()
            println "Commit ID retrieved from file: ${from_commitId}"
            // Now you can use 'commitId' in your build process
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
	stage('Identify Delta'){
	    // Identify changed files using Git
              //  def changedFiles = bat(returnStdout: true, script: "git diff --name-only ${from_commitId}...HEAD").trim()
                def changedFiles = bat(returnStdout: true, script: "git diff --name-only ${from_commitId} HEAD").trim()

		// Split the Git diff output into lines
		def lines = changedFiles.readLines()

		// Filter paths that start with "force-app"
		def forceAppPaths = lines.findAll { it.startsWith('force-app') }

		// Join the filtered paths with a single space
		result = forceAppPaths.join(' ')

		// Print the result
  		println 'Changed Files Start'
		println result
		println 'Changed Files end'
		  
	
		// Deploy only changed files
                if (!changedFiles.isEmpty()) {
                    if (isUnix()) {
                        rmsg = sh returnStdout: true, script: "sf project deploy start  --source-dir ${result} --target-org ${HUB_ORG}"
                    } else {
                 	rmsg = bat returnStdout: true, script: "sf project deploy start  --source-dir ${result} --target-org ${HUB_ORG}"
                    }
                } else {
                    echo "No changes detected. Skipping deployment."
                }
	}
			  
            printf rmsg
            println('Hello from a Job DSL script!')
            println(rmsg)
	    
	    // Retrieve the head commit ID
                headcommitId = bat(script: 'git rev-parse HEAD', returnStdout: true).trim()
                println "Head Commit ID: ${headcommitId}"
                
		// Save the headcommit ID to a file
		writeFile file: 'headcommit_id.txt', text: headcommitId

		
	
        }
    }
}
