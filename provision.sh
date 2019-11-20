#! /usr/bin/env bash

# https://docs.vapor.codes/3.0/install/ubuntu/
echo "add vapor repo"
eval "$(curl -sL https://apt.vapor.sh)"

# https://grafana.com/docs/installation/debian/
add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

echo "apt update"
apt update # > /dev/null 2&>1

echo "install packages"
apt install -y supervisor prometheus grafana vapor

systemctl enable grafana-server.service
systemctl start grafana-server
