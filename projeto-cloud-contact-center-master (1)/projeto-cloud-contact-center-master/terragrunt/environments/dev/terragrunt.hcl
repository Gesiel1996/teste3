
remote_state {
  backend = "s3"
  config = {
    bucket         = "infracc-dev-02"
    key            = "terragrunt/dev/${path_relative_to_include()}/terraform.tfstate"
    region         = "sa-east-1"
    encrypt        = true
    dynamodb_table = "infracc-dev-lock-table"
  }
}