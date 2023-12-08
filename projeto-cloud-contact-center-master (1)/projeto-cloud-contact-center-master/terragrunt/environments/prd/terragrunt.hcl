
remote_state {
  backend = "s3"
  config = {
    bucket         = "infracc-prd-02"
    key            = "terragrunt/prd/${path_relative_to_include()}/terraform.tfstate"
    region         = "sa-east-1"
    encrypt        = true
    dynamodb_table = "infracc-prd-lock-table"
  }
}