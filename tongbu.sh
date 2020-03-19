#!/bin/sh -e

yum -y install epel-release
yum -y update
yum -y install sshpass ncdu screen htop pdsh wget pssh fpart  nano lrzsz

cat <<"EOF" >/etc/yum.repos.d/resilio-sync.repo

[resilio-sync]
name=Resilio Sync
baseurl=http://linux-packages.resilio.com/resilio-sync/rpm/$basearch
enabled=1
gpgcheck=1

EOF

rpm --import https://linux-packages.resilio.com/resilio-sync/key.asc 

yum update -y && yum -y install resilio-sync

sed -i "s/127.0.0.1/0.0.0.0/g" /etc/resilio-sync/config.json && sed -i "s/127.0.0.1/0.0.0.0/g" /etc/resilio-sync/user_config.json

mkdir /home/wwwroot/player/video

chown -R rslsync /home/wwwroot/player && chown -R rslsync /home/wwwroot/player/video && chown -R rslsync /home/rslsync

service resilio-sync start
