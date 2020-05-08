#!/bin/sh

cat > /etc/yum.repos.d/MariaDB.repo << EOF
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.4/centos8-amd64
gpgkey = https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck = 1
EOF

microdnf update 2> /dev/null && microdnf install -y MariaDB-client 2> /dev/null

/wait_for_db.sh

exec /opt/jboss/tools/docker-entrypoint.sh -b 0.0.0.0
