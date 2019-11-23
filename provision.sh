#! /usr/bin/env bash

rm /etc/nginx/sites-enabled/default
chown root:root conf/*
mv conf/nginx-vapor.conf /etc/nginx/conf.d/vapor.conf
mv conf/supervisor-vapor.conf /etc/supervisor/conf.d/vapor.conf
rmdir conf

# if [[ !-d /usr/local/go ]]; then
#     curl -O https://storage.googleapis.com/golang/go1.12.9.linux-amd64.tar.gz
#     tar -xvf go1.12.9.linux-amd64.tar.gz
#     sudo chown -R root:root ./go
#     sudo mv go /usr/local
# fi
# export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# export GOPATH=$HOME/go
# ssh-keyscan github.com >> ~/.ssh/known_hosts
# git clone https://github.com/martin-helmich/prometheus-nginxlog-exporter.git
# git clone https://github.com/hnlq715/nginx-vts-exporter.git
# git clone https://github.com/nginxinc/nginx-prometheus-exporter.git

# https://docs.vapor.codes/3.0/install/ubuntu/
echo "add vapor repo"
eval "$(curl -sL https://apt.vapor.sh)"

# https://grafana.com/docs/installation/debian/
add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

echo "apt update"
apt update # > /dev/null 2&>1

echo "install packages"
apt install -y supervisor nginx prometheus grafana vapor prometheus-node-exporter golang-go

systemctl enable grafana-server.service
systemctl start grafana-server

supervisorctl reread
supervisorctl add
supervisorctl reload
supervisorctl restart vapor
systemctl restart nginx # Should probably just be a sig?
