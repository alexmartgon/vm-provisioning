pipeline {

    //Use any jenkins agent available (master or slaves)
    agent any
    options {
        ansiColor('xterm')
    }

    stages {
        
        stage("plan"){
            environment {
                VSPHERE_SERVER = credentials('vsphere-hp')
                //git_creds = credentials('AlexmartgonAccessToken')
                VSPHERE_USER = credentials('esxi-alejandro-role')
            }
            steps {
                echo 'Performing terraform plan and storing plan to apply at the next stage.'
                // sh 'export TF_VAR_vsphere_server=$VSPHERE_SERVER'
                // sh 'export TF_VAR_vsphere_user=$VSPHERE_USER_USR'
                // sh 'export TF_VAR_vsphere_password=$VSPHERE_USER_PSW'
                // sh 'echo $TF_VAR_vsphere_password'

                // echo 'Planning Terraform script'
                // sh 'terraform init'
                // sh 'terraform plan -input=false -out tfplan'
                // sh 'terraform show -no-color tfplan' //> tfplan.txt
                // terraform show -no-color tfplan  > tfplan.txt
                //sh 'cat tfplan.txt'

                sh '''
                    #!/bin/bash
                    export TF_VAR_vsphere_server=$VSPHERE_SERVER
                    export TF_VAR_vsphere_user=$VSPHERE_USER_USR
                    export TF_VAR_vsphere_password=$VSPHERE_USER_PSW
                    export PATH=$PATH:/home/jenkins/ovftool

                    echo "Remove the current terraform state"
                    rm terraform.tfstate

                    terraform init
                    terraform plan -input=false -out tfplan
                '''
                
                sh 'terraform show tfplan'
            }
        }

        stage("apply"){
            environment {
                VSPHERE_SERVER = credentials('vsphere-hp')
                //git_creds = credentials('AlexmartgonAccessToken')
                VSPHERE_USER = credentials('esxi-alejandro-role')
            }

            steps{
                echo 'Provisioning the VMs' 
                sh '''
                    #!/bin/bash
                    export TF_VAR_vsphere_server=$VSPHERE_SERVER
                    export TF_VAR_vsphere_user=$VSPHERE_USER_USR
                    export TF_VAR_vsphere_password=$VSPHERE_USER_PSW
                    export PATH=$PATH:/home/jenkins/ovftool

                    terraform init
                    terraform apply -input=false tfplan
                '''
            }
        }

        stage("output"){

            steps{
                echo 'Printing Terraform Output for the VMs created:' 
                sh '''
                    terraform output  -state=terraform.tfstate
                    echo "Schema: Name, Private IP, RAM, CPU."
                '''
                //echo 'Schema: Name, Private IP, RAM, CPU.'
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
