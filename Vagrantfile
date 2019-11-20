# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provision "shell", path: "provision.sh"

  # Vapor
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  # Grafana
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  # Prometheus
  config.vm.network "forwarded_port", guest: 9090, host: 9090
  # node_exporter
  config.vm.network "forwarded_port", guest: 9100, host: 9100
end
