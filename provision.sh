#! /usr/bin/env bash

echo "apt update"
apt update > /dev/null 2&>1

# https://docs.vapor.codes/3.0/install/ubuntu/
echo "add vapor repo"
eval "$(curl -sL https://apt.vapor.sh)"

echo "install packages"
apt install -y supervisor prometheus grafana vapor
