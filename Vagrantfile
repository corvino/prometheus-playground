# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provision "file", source: "conf", destination: "conf"
  config.vm.provision "shell", path: "provision.sh"
  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "playbooks/deployVapor.yml"
  end

  config.vm.network "forwarded_port", guest: 80, host: 8080 # nginx (to vapor)
  config.vm.network "forwarded_port", guest: 3000, host: 3000 # Grafana
  config.vm.network "forwarded_port", guest: 9090, host: 9090 # Prometheus
  config.vm.network "forwarded_port", guest: 9100, host: 9100 # node_exporter
  config.vm.network "forwarded_port", guest: 4040, host: 4040 # prometheus-nginxlog-exporter
end
