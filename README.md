## Automation to standup the infrastructure for a jamwiki demo site. ##

Uses remote config to manage state...

```bash
$ terraform remote config \
    -backend=s3 \ 
    -backend-config="bucket=tf.states" \
    -backend-config="key=jamwiki/terraform.tfstate" 
    -backend-config="region=us-west-2"
```

