
# Run the commands below in PS console after cd into the project folder

# Set Access Key (Get from IAM download credential csv)
aws configure set aws_access_key_id { aws_access_key_id}

# Set Secret (Get from IAM download credential csv)
aws configure set aws_secret_access_key { aws_secret_access_key }

# Verify login
aws sts get-caller-identity

# Initialize the directory with terraform init command.
terraform init

# Format onfiguration with below command.
terraform fmt

# Calidate configuration with below command.
terraform validate

 # Check the execution plan with command terraform plan
terraform plan

 # Terraform apply. 
 # Type "yes" in "Do you want to perform these actions" prompt, 
 #in some time you should see EC2 instance created.
 terraform apply
