{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Resource": [
        "arn:aws:s3:::${puppet_bucket}",
        "arn:aws:s3:::${puppet_bucket}/${secrets_key_prefix}*"
      ]
    }
  ]
}
