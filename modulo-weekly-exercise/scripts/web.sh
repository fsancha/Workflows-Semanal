#!/bin/bash
set -e

yum update -y
yum install -y httpd

systemctl start httpd
systemctl enable httpd

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
HOSTNAME=$(hostname)

cat <<EOF > /var/www/html/index.html
<h1>Hola Mundo</h1>
<p>Instance ID: $INSTANCE_ID</p>
<p>Hostname: $HOSTNAME</p>
EOF
