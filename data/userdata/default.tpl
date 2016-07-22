#!/bin/bash
yum install -y aws-cli jq python-pip
yum update -y aws-cli jq python-pip
export AWS_DEFAULT_REGION=${aws_region}

# get instance id from meta-data and name tag from ec2 api
if [ -z "$INSTANCE_ID" ]; then
  export INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
fi
export HOSTNAME=$(aws ec2 describe-tags \
  --filters Name=resource-id,Values=$INSTANCE_ID Name=tag-key,Values=Name \
  | jq '.Tags[].Value' | sed -e 's/\"//g')

# set hostname
if [ "$HOSTNAME" != "" ]; then
  hostname $HOSTNAME
  echo $HOSTNAME > /etc/hostname
fi

# install puppet
rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
yum install -y puppet-agent

# install r10k
puppet module install zack/r10k
curl https://raw.githubusercontent.com/ryno75/puppet_control/prod/r10k_setup.pp > /tmp/r10k_setup.pp
puppet apply /tmp/r10k_setup.pp
r10k deploy environment -pv

# configure puppet masterless
mkdir -p /etc/puppetlabs/puppet
mkdir -p /var/lib/puppet_masterless/ssl
cat << EOF > /etc/puppetlabs/puppet/puppet.conf
[main]'
environment = ${env}
logdir = /var/log/puppet_masterless
vardir = /var/lib/puppet_masterless
ssldir = /var/lib/puppet_masterless/ssl
rundir = /var/run/puppet
factpath = $confdir/facter
EOF

# download eyaml keys
aws s3 cp s3://${puppet_bucket}/${secrets_key_prefix}private_key.pkcs7.pem /etc/puppetlabs/puppet/keys/
aws s3 cp s3://${puppet_bucket}/${secrets_key_prefix}public_key.pkcs7.pem /etc/puppetlabs/puppet/keys/
chmod 440 /etc/puppetlabs/puppet/keys/*

# run it
puppet apply /etc/puppetlabs/code/environments/${env}/manifests/site.pp
