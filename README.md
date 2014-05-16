# Packer templates for Ubuntu

### Overview

The repository contains templates for Ubuntu that can create Vagrant boxes
using Packer.

## Current Boxes

64-bit boxes:

* [box-cutter/ubuntu1404](https://vagrantcloud.com/box-cutter/ubuntu1404) - Ubuntu 14.04 Server 64-bit
* [box-cutter/ubuntu1404-desktop](https://vagrantcloud.com/box-cutter/ubuntu1404-desktop) - Ubuntu 14.04 Desktop 64-bit
* [box-cutter/ubuntu1404-docker](https://vagrantcloud.com/box-cutter/ubuntu1404-docker) - Ubuntu 14.04 Server with Docker 64-bit
* [box-cutter/ubuntu1204](https://vagrantcloud.com/box-cutter/ubuntu1204) - Ubuntu 12.04 Server 64-bit
* [box-cutter/ubuntu1204-desktop](https://vagrantcloud.com/box-cutter/ubuntu1204-desktop) - Ubuntu 12.04 Desktop 64-bit
* [box-cutter/ubuntu1204-docker](https://vagrantcloud.com/box-cutter/ubuntu1204-docker) - Ubuntu 12.04 Server with Docker 64-bit
* [box-cutter/ubuntu1004](https://vagrantcloud.com/box-cutter/ubuntu1004)  - Ubuntu 10.04 Server 64-bit

32-bit boxes:

* [box-cutter/ubuntu1404-i386](https://vagrantcloud.com/box-cutter/ubuntu1404-i386) - Ubuntu 14.04 Server 32-bit
* [box-cutter/ubuntu1204-i386](https://vagrantcloud.com/box-cutter/ubuntu1204-i386) - Ubuntu 12.04 Server 32-bit
* [box-cutter/ubuntu1004-i386](https://vagrantcloud.com/box-cutter/ubuntu1004-i386) - Ubuntu 10.04 Server 32-bit

## Building the Vagrant boxes

To build all the boxes, you will need Packer ([Website](packer.io)) 
and both VirtualBox and VMware Fusion installed.

A GNU Make `Makefile` drives the process via the following targets:

    make        # Build all the box types (VirtualBox & VMware)
    make test   # Run tests against all the boxes
    make list   # Print out individual targets
    make clean  # Clean up build detritus
    
### Tests

The tests are written in [Serverspec](http://serverspec.org) and require the
`vagrant-serverspec` plugin to be installed with:

    vagrant plugin install vagrant-serverspec
    
The `Makefile` has individual targets for each box type with the prefix
`test-*` should you wish to run tests individually for each box.

Similarly there are targets with the prefix `ssh-*` for registering a
newly-built box with vagrant and for logging in using just one command to
do exploratory testing.  For example, to do exploratory testing
on the VirtualBox training environmnet, run the following command:

    make ssh-box/virtualbox/win2008r2-standard-nocm.box
    
Upon logout `make ssh-*` will automatically de-register the box as well.

### Makefile.local override

You can create a `Makefile.local` file alongside the `Makefile` to override
some of the default settings.  It is most commonly used to override the
default configuration management tool, for example with Chef:

    # Makefile.local
    CM := chef

Changing the value of the `CM` variable changes the target suffixes for
the output of `make list` accordingly.

Possible values for the CM variable are:

* `nocm` - No configuration management tool
* `chef` - Install Chef
* `puppet` - Install Puppet
* `salt`  - Install Salt

You can also specify a variable `CM_VERSION`, if supported by the
configuration management tool, to override the default of `latest`.
The value of `CM_VERSION` should have the form `x.y` or `x.y.z`,
such as `CM_VERSION := 11.12.4`

Another use for `Makefile.local` is to override the default locations
for the Ubuntu install ISO files.

For Ubuntu, the ISO path variables are:

* UBUNTU1004_SERVER_AMD64
* UBUNTU1004_SERVER_I386
* UBUNTU1204_SERVER_AMD64
* UBUNTU1204_SERVER_I386
* UBUNTU1204_ALTERNATE_AMD64
* UBUNTU1304_SERVER_AMD64
* UBUNTU1304_SERVER_I386
* UBUNTU1310_SERVER_AMD64
* UBUNTU1310_SERVER_I386
* UBUNTU1404_SERVER_AMD64
* UBUNTU1404_SERVER_I386

This override is commonly used to speed up Packer builds by
pointing at pre-downloaded ISOs instead of using the default
download Internet URLs:
`UBUNTU1404_SERVER_AMD64 := file:///Volumes/Ubuntu/ubuntu-14.04-server-amd64.iso`
