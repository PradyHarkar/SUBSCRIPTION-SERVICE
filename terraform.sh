#!/bin/bash

# Set the Terraform directory
TF_DIR="./infra"

# Navigate to Terraform directory
cd $TF_DIR || exit

echo "Initializing Terraform..."
terraform init

echo "Validating Terraform configuration..."
terraform validate

echo "Creating an execution plan..."
terraform plan -out=tfplan

echo "Applying the plan..."
terraform apply -auto-approve tfplan

echo "Terraform execution completed!"