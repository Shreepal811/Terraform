What are Workspaces?

Terraform workspaces let you manage multiple state files within a single configuration — useful for managing dev/staging/prod environments without duplicating code.


# List all workspaces (* = current)
terraform workspace list

# Show current workspace
terraform workspace show

# Create a new workspace
terraform workspace new <name>

# Switch to an existing workspace
terraform workspace select <name>

# Delete a workspace (must not be current)
terraform workspace delete <name>