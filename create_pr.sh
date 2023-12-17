#!/bin/bash

# Check if version argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <new_version>"
  exit 1
fi

# Assign input arguments to variables
new_version=$1
branch_name="update-nginx-$new_version"
terraform_dir="terraform"

# Clone the repository
git clone https://github.com/sm211116/nginx-deployment.git
cd nginx-deployment

# Create a new branch
git checkout -b $branch_name

# Update the Terraform code with the new version
sed -i "s/nginx_version = \".*\"/nginx_version = \"$new_version\"/" $terraform_dir/main.tf

# Commit the changes
git add $terraform_dir/main.tf
git commit -m "Update nginx version to $new_version"

# Push the branch to GitHub
git push origin $branch_name

# Create a pull request
hub pull-request -m "Update nginx version to $new_version" -b main -h $branch_name

# Wait for user to merge the pull request

# Switch back to the main branch
git checkout main

# Pull the latest changes
git pull

# Apply Terraform changes
terraform init $terraform_dir
terraform apply -auto-approve $terraform_dir

# Clean up: delete the local branch
git branch -d $branch_name
