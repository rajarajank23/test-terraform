region          = "us-east-1"
key_name        = "my-key-pair"
public_key_path = "aws_key_pair.key_pair.key_name"
ami_id          = "ami-0c02fb55956c7d316" # Replace with your AMI
instance_type   = "t2.micro"
s3_bucket_name  = "rajarajan-terraformstatefile"