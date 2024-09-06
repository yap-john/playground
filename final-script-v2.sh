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

# Variables
repo_dir="$(pwd)/$git_folder"
eks_path="$repo_dir/eks-cluster"
init_terra_path="$repo_dir/init-terraform"
package_path="$repo_dir/packages"
app_path="$repo_dir/web-app"

install_packages_script="$package_path/install-packages.sh"
terraform_init="$init_terra_path/terraform.sh"
terraform_eks="$eks_path/terraform-eks.sh"
deploy_apps="$app_path/deploy-apps.sh"

echo "-----Initiating script run-----"

echo "Options"
echo "1) Run the whole script"
echo "2) Install required packages"
echo "3) Run terraform for infrastructure provisioning"
echo "4) Run terraform for EKS cluster"
echo "5) Deploy webapps"

echo "Choose a script to run (1-6)"
read user_input

# Clone branch containing the scripts
#git clone --branch $branch_name $git_url
git clone $git_url

# Function to change directory, run a script, and return
run_script() {
    local script_name="$1"
    local dir="$2"
    if [ -n "$dir" ]; then
        cd "$dir" || { echo "Failed to change directory to $dir"; exit 1; }
    fi
    echo "Running $script_name..."
    sh "$script_name"
    cd - || exit
}

# Function to run all scripts
run_all_scripts() {
    run_script "$install_packages_script" "$package_path"
    run_script "$terraform_init" "$init_terra_path"
    run_script "$terraform_eks" "$eks_path"
    run_script "$deploy_apps" "$app_path"
}

# Main logic based on user input
case "$user_input" in
    1)
        echo "----- Running the script from top down"
        run_all_scripts
        ;;
    2)
        echo "----- Installing required packages on machine"
        run_script "$install_packages_script" "$package_path"
        ;;
    3)
        echo "----- Running terraform for infra provisioning"
        run_script "$terraform_init" "$init_terra_path"
        ;;
    4)
        echo "----- Running terraform for eks cluster"
        run_script "$terraform_eks" "$eks_path"
        ;;
    5)
        echo "----- Deploying web applications"
        run_script "$deploy_apps" "$app_path"
        ;;
    *)
        echo "----- Invalid user input"
        ;;
esac

# Clean up cloned files
echo "-----Cleaning up cloned files-----"
rm -rf "$repo_dir"

echo "-----Script execution completed-----"
