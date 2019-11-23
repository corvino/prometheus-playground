### UIs

* [Prometheus](http://localhost:9090/graph)
* [Grafana](http://localhost:3000)

### Ansible

Ansible is used to sync and build the [https://vapor.codes](Vapor) app,
mainly because it makes using rsync to the vagrant box easy.

This deploy and can also be done through the `deploy.sh` shell
wrapper. This scripe should really take an argument that specifies the
playbook, with the vapor deploy as the default. But one thing at a time.

### Vapor

Ran into neeind to specify binding to 0.0.0.0 to make the Vapor service
accessible externally. Maybe this can be handled through nginx instead?
