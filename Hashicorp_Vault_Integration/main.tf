provider "aws" {
  region = "us-east-1"
}

// Add vault as provider
provider "vault" {
  address = "http://<your-ec2-ip>:8200"
  skip_child_token = true
  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = "<role-id>"
      secret_id = "<secret-id>"
    }
  }
}

data "vault_kv_secret_v2" "secret_data" {
  mount = "<mount-name>"
  name  = "<secret-path>"
}

// use vault secret-name
resource "aws_s3_bucket" "name" {
  bucket = data.vault_kv_secret_v2.secret_data.data["<secret-name>"]
}