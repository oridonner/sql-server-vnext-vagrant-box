#!/usr/bin/env bash

set -eux

# sql server public repository GPG keys
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Register the Microsoft Ubuntu repository for sql-server
curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server.list | sudo tee /etc/apt/sources.list.d/mssql-server.list

# Register the Microsoft Ubuntu repository for sql-server tools
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list


# sql server installation
sudo apt-get -y update
sudo apt-get install -y mssql-server
sudo apt-get install -y mssql-server-agent
# sql server instatiation
sudo /bin/bash -c "export SA_PASSWORD='vnext@2017'; /opt/mssql/bin/mssql-conf setup accept-eula"

# sqlcmd and bcp unattended installation
export DEBIAN_FRONTEND=noninteractive
apt-get update -q
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" mssql-tools unixodbc-dev

