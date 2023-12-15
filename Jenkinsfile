#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME

    def HUB_ORG="san.red24@yahoo.com.dev"
    def SFDC_HOST="https://login.salesforce.com"
    def JWT_KEY_CRED_ID="7f587601-a72c-4350-9bc6-8f465171fb82"
    def CONNECTED_APP_CONSUMER_KEY="3MVG9G9pzCUSkzZvY.1HulJWPyRY233.k6U.EqEX7bqKFBRkzM0qqqTJklH12Govg6z1NzW7y1Ch.l8QrAczD"

    println 'KEY IS'
    println HUB_ORG
    println SFDC_HOST
    println JWT_KEY_CRED_ID
    println CONNECTED_APP_CONSUMER_KEY

    def toolbelt = tool 'toolbelt'

    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
  }
}