# Puppet linux_hardening

## Module Description

The linux_hardening module provides hardening on Linux Centos 7 configurations.

This module manages authentification, services, firewall, selinux rules, auditd and kernel hardening.

## Setup

### Beginning with Linux_hardening

To harden a system with the default options:

`include 'linux_hardening'`.

To customize options, such as selinux configurations settings, you must also pass in an override hash:

```puppet
class { 'linux_hardening':
  selinux_mode => 'permissive', }
}
```

## Testing

Our Puppet modules provide Gemfiles, which can tell a Ruby package manager such as bundler what Ruby packages, or Gems, are required to build, develop, and test this software.

Please make sure you have bundler installed on your system, and then use it to install all dependencies needed for this project in the project root by running.

```shell
bundle install
```

### Running Tests
With all dependencies in place and up-to-date, run the tests:

### Acceptance Tests
Some Puppet modules also come with acceptance tests, which use beaker. These tests spin up a virtual machine under VirtualBox, controlled with Vagrant, to simulate scripted test scenarios. In order to run these, you need both Virtualbox and Vagrant installed on your system.

Run the tests by issuing the following command

```shell
rake beaker
```

## Limitations

This module has been tested on:
*   CentOS 7

Testing on other platforms has been minimal and cannot be guaranteed.
