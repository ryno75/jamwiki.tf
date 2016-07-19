#!/bin/bash
yum install -y aws-cli jq python-pip
yum update -y aws-cli jq python-pip
export AWS_DEFAULT_REGION=${aws_region}
if [ -z "$INSTANCE_ID" ]; then
  export INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
fi
export HOSTNAME=$(aws ec2 describe-tags \
  --filters Name=resource-id,Values=$INSTANCE_ID Name=tag-key,Values=Name \
  | jq '.Tags[].Value' | sed -e 's/\"//g')
# set hostname
hostname $HOSTNAME
echo $HOSTNAME > /etc/hostname

# install puppet
rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
yum install -y puppet-agent

# install r10k
puppet module install zack/r10k
curl https://raw.githubusercontent.com/ryno75/puppet_control/prod/r10k_setup.pp > /tmp/r10k_setup.pp
puppet apply /tmp/r10k_setup.pp
r10k deploy environment -pv

# install cron job to run puppet agent every 30 minutes on the hour
echo "0,30 * * * * root puppet apply /etc/puppetlabs/code/environments/${env}/manifests/site.pp" > /etc/cron.d/puppet-agent

# run it
puppet apply /etc/puppetlabs/code/environments/${env}/manifests/site.pp

