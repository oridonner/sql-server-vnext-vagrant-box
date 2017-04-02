#!/usr/bin/env bash

set -eux

# Sample custom configuration script - add your own commands here
# to add some additional commands for your environment
#
# For example:
# yum install -y curl wget git tmux firefox xvfb
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server.list | sudo tee /etc/apt/sources.list.d/mssql-server.list

sudo apt-get -y update
sudo apt-get install -y mssql-server
sudo apt-get install -y mssql-server-agent

sudo /bin/bash -c "export SA_PASSWORD='vnext@2017'; /opt/mssql/bin/mssql-conf setup accept-eula"