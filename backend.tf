# Create S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "rajarajan-terraformstatefile"
}

# Enforce bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Restrict public access to the bucket
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Optional: Remove ACL block if using Bucket Ownership Controls
# resource "aws_s3_bucket_acl" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id
#   acl    = "private"
# }

# Create DynamoDB table for Terraform state locking
#resource "aws_dynamodb_table" "terraform_lock" {
  #name         = "state-lock"
 # billing_mode = "PAY_PER_REQUEST"
 # hash_key     = "LockID"

 # attribute {
 #   name = "LockID"
  #  type = "S"
  #}
#}

 #Configure the backend to use the newly created S3 bucket
#terraform {
  #backend "s3" {
  #  bucket         = "rajarajan-terraformstatefile"
  #  key            = "global/terraform.tfstate"
  #  region         = "us-east-1"
    #dynamodb_table = "state-lock"  # Remove this line to disable locking
  #  encrypt        = true
 # }
#}

terraform {
  backend "s3" {
   bucket      = "rajarajan-terraformstatefile"
   key        = "global/terraform.tfstate"
   region     = "us-east-1"
   encrypt    = true
    use_lockfile = true # New S3 native locking!
  }
}