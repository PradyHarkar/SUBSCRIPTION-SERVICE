/project-root
  /src                # React components (e.g., App.js, Login.js)
  /public             # Static files (e.g., index.html)
  Dockerfile          # Docker configuration to containerize the React app
  package.json        # Dependencies and scripts for the React project
  /infra              # Kubernetes YAML files and azure-pipelines.yml
    deployment.yaml   # Kubernetes Deployment configuration
    service.yaml      # Kubernetes Service configuration
    azure-pipelines.yml # CI/CD pipeline configuration for Azure DevOps
  variables.tf        # Terraform variables (if used)
  main.tf             # Terraform configuration (if used)