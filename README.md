## Packer template for SQL Server vNext on Ubuntu 16.04

This Packer template builds a Vagrant box for VirtualBox, but can be extended for other virtualization providers (VMWare,Parallels).

Ubuntu Server configuration variables file: ubuntu.json

SQL Server vNext provisionig file: script/mssql.sh


To build the box, execute the following script :

`packer build -var-file=ubuntu1604.json ubuntu.json`
 or
`packer build -force -var-file=ubuntu1604.json ubuntu.json`
 

Vagrant box repo:  https://atlas.hashicorp.com/sqldevops/boxes/sql-server-vnext


This template is based on Boxcutter templates repo : https://github.com/boxcutter


Add the box to local Vagrant boxes repository




