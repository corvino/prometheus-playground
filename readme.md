### The Web UIs

* [Prometheus](http://localhost:9090/graph)
* [Grafana](http://localhost:3000)

### Exporter Metrics Endpoints

* [prometheus-nginxlog-exporter](https://github.com/martin-helmich/prometheus-nginxlog-exporter) (Also see [NGINX Performance Metrics with Prometheus](https://www.martin-helmich.de/en/blog/monitoring-nginx.html))
  * [prometheus-nginxlog-exporter](http://localhost:4040/metrics)
* [node exporter](https://github.com/prometheus/node_exporter)
  * [node exporter](http://localhost:9100/metrics)

### Ansible

Ansible is used to sync and build the [Vapor](https://vapor.codes) app,
mainly because it makes using rsync to the vagrant box easy.

This deploy and can also be done through the `deploy.sh` shell
wrapper. This scripe should really take an argument that specifies the
playbook, with the vapor deploy as the default. But one thing at a time.

### Vapor

Ran into neeind to specify binding to 0.0.0.0 to make the Vapor service
accessible externally. Maybe this can be handled through nginx instead?
