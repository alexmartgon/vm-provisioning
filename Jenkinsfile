pipeline {

    //Use any jenkins agent available (master or slaves)
    agent any

    stages {
        
        stage("plan"){
            environment {
                VSPHERE_SERVER = credentials('vsphere-hp')
                //git_creds = credentials('AlexmartgonAccessToken')
                VSPHERE_USER = credentials('esxi-alejandro-role')
            }
            steps {
                echo 'Setting up environment for terraform'
                // sh 'export TF_VAR_vsphere_server=$VSPHERE_SERVER'
                // sh 'export TF_VAR_vsphere_user=$VSPHERE_USER_USR'
                // sh 'export TF_VAR_vsphere_password=$VSPHERE_USER_PSW'
                // sh 'echo $TF_VAR_vsphere_password'

                // echo 'Planning Terraform script'
                // sh 'terraform init'
                // sh 'terraform plan -input=false -out tfplan'
                // sh 'terraform show -no-color tfplan' //> tfplan.txt
                sh '''
                    #!/bin/bash
                    export TF_VAR_vsphere_server=$VSPHERE_SERVER
                    export TF_VAR_vsphere_user=$VSPHERE_USER_USR
                    export TF_VAR_vsphere_password=$VSPHERE_USER_PSW
                    echo $TF_VAR_vsphere_password

                    Planning Terraform script
                    terraform init
                    terraform plan -input=false -out tfplan
                    terraform show -no-color tfplan
                    ''' // > tfplan.txt
            }
        }

        stage("apply"){

            steps{
                echo 'Provisioning the VMs' 
            }
        }

        // stage("clean-up"){

        //     steps{
        //         echo 'Cleaning up environment variables.'
        //         //sh('unset TF_VAR_vsphere_server TF_VAR_vsphere_user TF_VAR_vsphere_password')
        //     }
        // }

    }

}
