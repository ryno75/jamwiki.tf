{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GettObject",
            "Resource": "arn:aws:s3:::${puppet_bucket}/${secrets_key_prefix}*"
        }
    ]
}
