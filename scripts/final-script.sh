#!/bin/bash

#variables
#branch_name='jenkins-terraform'
#echo "enter git username"
#read git_user
#echo "enter git pass"
#read git_pass
#git_url="https://$git_user:$git_pass@github.com/opswerks/capstone-iaac.git"

git_url='https://github.com/yap-john/playground.git'
git_folder=$(echo $git_url | rev | cut -d "/" -f1 | rev | cut -d "." -f1)

#scriptpath
script_path="$gitfolder/scripts/"

#scriptfiles
install_packages_script='install_packages.sh'
terraform_init='terraform.sh'
terraform_eks='terraform-eks.sh'
setup_workers='setup-workers.sh'
deploy_apps='deploy-apps.sh'

#echo $git_folder
##clone branch containing the scripts
#git clone --branch $branch_name $git_url

echo "-----Initiating script run-----"

echo "Options"
echo "1) Run the whole script"
echo "2) Install required packages"
echo "3) Run terraform for infrastructure provisioning"
echo "4) Run terraform for EKS cluster"
echo "5) Setup worker nodes connection"
echo "6) Deploy webapps"

echo "Choose a script to run (1-6)"
read user_input

echo "-----Cloning repository-----"
git clone $git_url

if [ -z "$user_input" ]; then
          echo "No command entered. Please try again."
            exit 1
fi

# Function to change directory and run a script
run_script() {
    local script_name="$1"
    echo "Running $script_name..."
    cd "$script_path" || exit 1
    sh "$script_name"
}

# Function to run all scripts
run_all_scripts() {
    run_script "$install_packages_script"
    run_script "$terraform_init"
    run_script "$terraform_eks"
    run_script "$setup_workers"
    run_script "$deploy_apps"
}

# Main logic based on user input
case "$user_input" in
    1)
        echo "----- Running the script from top down"
        run_all_scripts
        ;;
    2)
        echo "----- Installing required packages on machine"
        run_script "$install_packages_script"
        ;;
    3)
        echo "----- Running terraform for infra provisioning"
        run_script "$terraform_init"
        ;;
    4)
        echo "----- Running terraform for eks cluster"
        run_script "$terraform_eks"
        ;;
    5)
        echo "----- Setting up connection for the worker nodes"
        run_script "$setup_workers"
        ;;
    6)
        echo "----- Deploying web applications"
        run_script "$deploy_apps"
        ;;
    *)
        echo "----- Invalid user input"
        ;;
esac

#to run scripts, relative path to the sh file and run.
#e.g. ./$git_folder/scripts/<sh file>

echo "-----Cleaning up cloned files-----"
