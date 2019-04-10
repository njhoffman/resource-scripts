#!/bin/bash

pip install --upgrade --user awscli
aws --version
aws configure
aws-shell

##### aws-shell (filtering data)
apt-get install -y python-pip libpython-dev
pip install aws-shell
pip install --upgrade aws-shell
.edit # opens comamnds in editor to make shell script
.profile taponit
.cd /tmp
!pwd
!ls

##### query (filtering data)
# http://jmespath.org/examples.html

ec2 describe-volumes --query 'Volumes[0]' --output table # output text, output json
ec2 describe-volumes --query 'Volumes[*].{ID:VolumeId,AZ:AvailabilityZone,Size:Size}'
ec2 describe-volumes --query 'Volumes[?AvailabilityZone==`us-west-2a`]' --max-items 100 --page-size 10
ec2 describe-instances --query 'Reservations[].Instances[].{" Name": Tags[?Key==`Name`].Value | [0], ID:InstanceId, Image:ImageId, DNS:PublicDnsName, State:State.Name}'
ec2 describe-instances --filters "Name=vpc-id,Values=vpc-e2f178e8b" "Name=instance-state-name,Values=Running" --output text | column -t | sort -n -k 2

##### ec2
ec2 describe | -regions -tags -instances -spot-price-history -key-pairs -volumes -volume-status -vpcs -subnets -hosts -images
  ec2 describe-instances --instance-ids i-0123456789abcdef
ec2 create-key-pair --key-name dev-servers
ec2 get-console-output --instance-id i-44a44ac3
ec2 start-instances --instance-ids i-dddddd70  # stop, reboot, terminate
ec2 terminate-instances --dry-run --instance-ids i-dddddd70
ec2 modify-instance-attribute --instance-id i-44a44ac3 --instance-type "{\"Value\": \"t2.nano\"}"
ec2 create-tags --resources i-dddddd70 --tags Key=Department,Value=Finance
# list stopped instances and reason
ec2 describe-instances --filters Name=instance-state-name,Values=stopped --region us-east-1 --output json | jq -r .Reservations[].Instances[].StateReason.Message
# add storage (block device) to instance
ec2 attach-volume --volume-id vol-1d5cc8cc --instance-id i-dddddd70 --device /dev/sdh
# create a new image from running instance
ec2 create-image --instance-id i-44a44ac3 --name "Dev AMI" --description "AMI for development server"
# launch ec2 instance (must have AMI image, key pair, security group already created)
ec2 run-instances --image-id ami-22111148 --count 1 --instance-type t1.micro --key-name stage-key --security-groups my-aws-security-group  #--subnet-id --block-device-mappings --user-data --iam-instance-profile
# delete image
ec2 deregister-image --image-id ami-2d574747
ec2 delete-snapshopt --snapshopt-id snap-4e665454
# enable termination protection
ec2 modify-instance-attribute --instance-id i-44a44ac3 --disable-api-termination
# enable cloudwatch monitoring
ec2 monitor-instances --instance-ids i-44a44ac3
# load instance form json
ec2 run-instances --generate-cli-skeleton > ec2runinst.json
ec2 run-instances --cli-input-json file://ec2runinst.json # set DryRun to true first
# security groups
ec2 describe-security-groups
ec2 update-security-group-rule-descriptions-ingress --group-id sg-123abc12 --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "IpRanges": [{"CidrIp": "203.0.113.0/16", "Description": "SSH access from ABC office"}]}]'
ec2 authorize-security-group-ingress --group-id sg-903004f8 --protocol tcp --port 22 --cidr 203.0.113.0/24
ec2 authorize-security-group-ingress --group-id sg-111aaa22 --protocol tcp --port 80 --source-group sg-1a2b3c4d # allow inboud traffic from another secuiryt group
ec2 authorize-security-group-ingress --group-id sg-123abc12 --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 3389, "ToPort": 3389, "IpRanges": [{"CidrIp": "203.0.113.0/24", "Description": "RDP access from NY office"}]}]'


##### elasticsearch
es list-tags --arn arn:aws:es:us-east-1:410442588306:domain/logs
es list-domain-names
es list-elasticsearch-version
es list-elasticsearch-instance-types
es describe-elasticsearch-domain --domain logs


##### users
iam list-users --output table
iam list-groups --output table
iam list-roles --output table

##### s3
s3 ls
# delete s3 bucket
s3 rb s3://bucket-name --force
# copy a directory and subfolders from pc to s3
s3 cp MyFolder s3://bucket-name -- recursive --region -us-east-1
s3 rm s3://mybucket --recursive
s3 sync s3://source-bucket s3://dest-bucket
# list sizes of s3 bucket and its conents
s3api list-objects --bucket BUCKETNAME --output json --query "[sum(Contents[].Size), length(Contents[])]"

##### elasticcache
elasticache describe-cache-clusters --show-cache-node-info
elasticache describe-cache-parameters --cache-parameter-group-name redis-aof --query \
elasticache describe-snapshots
elasticache describe-subnet-groups

##### rds
rds describe-account-attributes
rds describe-db-instances
rds describe-db-snapshots
rds describe-db-security-groups
rds describe-db-subnet-groups
rds describe-db-paramter-groups
rds describe-db-paramter --db-parameter-group-name default.sqlserver-se-12.0
rds describe-option-groups

##### elb
elb describe-load-balancers
elb decribe-instance-health --load-balancer-name TapOnItAdmin
elb describe-account-limits
elb describe-load-balancer-attributes

##### cloudwatch
cloudwatch list-dashboards
cloudwatch list-metrics --namespace AWS/EC2 --metric-name NetworkOut
cloudwatch get-metric-statistics --metric-name CPUUtilization --start-time 2017-04-08T23:18:00 --end-time 2017-05-08T23:18:00 --period 3600 --statistics Maximum|Minimum|Sum|Average|SampleCount --dimensions Name=InstanceId,Value=i-abcdef --unit "Seconds|Microseconds|Bytes|Gigabytes|Megabits|Gigabytes/Second|Count/Second"
cloudwatch describe-alarms
cloudwatch describe-alarm-history

##### route53
route53 list-hosted-zones
route53 get-hosted-zone --id Z1KZR1XOCT2Z49
route53 list-resource-record-sets --hosted-zone-id Z1KZR1XOCT2Z49

##### elasticbeanstalk
elasticbeanstalk describe | -instances-health  -applications -applications-version -environments -environments-health -events
elasticbeanstalk describe-environment-resources --environment-name app-prod

eb init --keyname mykey.pem
eb list -av
eb status
eb health --refresh
eb events -f # <-- useful
eb logs --all # --instance
eb open
eb create UMIServer-stage --envvars NODE_ENV=stage,KEYMETRICS_PUBLIC=wi7kitpgaf9avqv,KEYMETRICS_SECRET=daxu4654wwa04qw --keyname jumpOnIt.pem --single --vpc.securitygroups in-websites --verbose
eb deploy --staged
eb config
eb terminate environment_name # --all --force
eb printenv
eb setenv NODE_ENV=stage
eb ssh
cat ~/.bashrc_user_aws | eb ssh --command 'cat > .bashrc_user'
# [ -f ~/.bashrc_user ] && . ~/.bashrc_user

##### elasticbeanstalk
ssh -i ~/.ssh/jumpOnIt.pem ec2-user@ip.com
/var/log/eb-activity.log
/var/log/eb-docker/containers/eb-current-app

##### troubleshoot elb latency
# caused by network connectivity, ELB configuration, or web application server issues (memory, cpu, config, database dependencies)
for X in `seq 60`; do curl -Ik -w "HTTPCode=%{http_code} TotalTime=%{time_total}\n" smsReceive-production.h5s7dqspsv.us-east-1.elasticbeanstalk.com/health -so /dev/null; done
