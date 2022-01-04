resource "aws_kms_key" "kms_key" {

  description = "This key is used to encrypt bucket objects"

}

resource "aws_dynamodb_table" "dynamodb_tflock" {
  name           = "tf-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-tf-lock"
    Environment = "production"
  }
}

resource "aws_s3_bucket" "bucket_tfstate" {

  bucket = "tfstate-bucket"
  acl    = "private"

  lifecycle {
    prevent_destroy = false
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id = "expire-all-noncurrent-tfstate"
    prefix  = "production/"
    enabled = true

    noncurrent_version_expiration {
      days = 1
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.kms_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

}


resource "aws_s3_bucket_public_access_block" "block_public_access_bucket_tfstate" {

  bucket = aws_s3_bucket.bucket_tfstate.id

  block_public_acls       = var.block_all_public_access_tfstate || var.block_public_acls_tfstate ? true : false
  block_public_policy     = var.block_all_public_access_tfstate || var.block_public_policy_tfstate ? true : false
  ignore_public_acls      = var.block_all_public_access_tfstate || var.ignore_public_acls_tfstate ? true : false
  restrict_public_buckets = var.block_all_public_access_tfstate || var.restrict_public_buckets_tfstate ? true : false

}
