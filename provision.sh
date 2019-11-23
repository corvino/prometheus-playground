#! /usr/bin/env bash

# https://www.martin-helmich.de/en/blog/monitoring-nginx.html
wget https://github.com/martin-helmich/prometheus-nginxlog-exporter/releases/download/v1.3.0/prometheus-nginxlog-exporter
chmod 755 prometheus-nginxlog-exporter
mv prometheus-nginxlog-exporter /usr/local/bin/
wget https://raw.githubusercontent.com/martin-helmich/prometheus-nginxlog-exporter/master/systemd/prometheus-nginxlog-exporter.service
sed -e 's/prometheus-nginxlog-exporter.*$/prometheus-nginxlog-exporter/' prometheus-nginxlog-exporter.service > /etc/systemd/system/prometheus-nginxlog-exporter.service
rm prometheus-nginxlog-exporter.service
systemctl enable prometheus-nginxlog-exporter
systemctl start prometheus-nginxlog-exporter

# https://github.com/hnlq715/nginx-vts-exporter.git
# https://github.com/nginxinc/nginx-prometheus-exporter.git

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

rm /etc/nginx/sites-enabled/default
chown -R root:root conf/*
mv conf/nginx-vapor.conf /etc/nginx/conf.d/vapor.conf
mv conf/supervisor-vapor.conf /etc/supervisor/conf.d/vapor.conf
rmdir conf

systemctl enable grafana-server.service
systemctl start grafana-server

supervisorctl reread
supervisorctl add
supervisorctl reload
supervisorctl restart vapor
systemctl restart nginx # Should probably just be a sig?
