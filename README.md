# Puppet linux_hardening

## Description

This Puppet module provides hardening on Linux Centos 7 configurations.

## Requirements

* Puppet
* Puppet modules: linux_hardening': `thias-sysctl` (>= 1.0.6), `puppetlabs-stdlib` (>= 1.0.0)

## Usage

After adding this module, you can use the class:

```
class { 'linux_hardening':
}
```

## Overwriting default options

You can overwrite hiera data:

```
node 'mynode' {
  class { 'linux_hardening':
    selinux_mode => 'permissive', }
}
```


