
class linux_hardening::packages(
  $package_libreswan = true,
  $package_chrony    = true,
  $package_screen    = false,

) {
  if $package_libreswan == true {
    package { 'libreswan':
      ensure   => 'latest',
      provider => 'yum',
    }
  }

  if $package_chrony == true {
    package { 'chrony':
      ensure   => 'latest',
      provider => 'yum',
    }
  }

  service { 'chronyd':
    ensure  => 'running',
    enable  => true,
    require => Package['chrony'],
  }

  if $package_screen == true {
    package { 'screen':
      ensure   => 'latest',
      provider => 'yum',
    }
  }

}