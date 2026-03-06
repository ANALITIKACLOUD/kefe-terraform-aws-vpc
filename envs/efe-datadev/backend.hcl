bucket         = "kefe-dataops-prd-s3-tfstate"
key            = "vpc/data-dev/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "kefe-dataops-dynamodb-terraform-locks"
encrypt        = true
