class linux_hardening::sshd (
    $ssh_banner                 = true,
    $ssh_strong_ciphers         = 'aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc,aes192-cbc,aes256-cbc',
    $ssh_idle_timeout           = '900',
    $ssh_strong_hmacs           = 'hmac-sha2-512,hmac-sha2-256,hmac-sha1',
    $ssh_only_ssh_2             = true,
    $ssh_disable_x11_forwarding = true,
    $ssh_disable_empty_password = true,
    $ssh_client_alive_count_max = '0',
    $ssh_disable_user_env       = true,
) {

  package { 'openssh-server':
    ensure   => 'latest',
    provider => 'yum',
  }

  service { 'sshd':
    ensure  => 'running',
    enable  => true,
    require => Package['openssh-server'],
  }

  file { 'Set banner':
    ensure => bool2str($ssh_banner, 'present', 'absent'),
    path   => '/etc/issue',
    source => 'puppet:///modules/linux_hardening/sshd/issue.client',
  }

  if $ssh_banner == true {
    file_line { 'Set banner in config file sshd':
      ensure  => present,
      path    => '/etc/ssh/sshd_config',
      match   => '^Banner',
      line    => 'Banner /etc/issue',
      notify  => Service['sshd'],
      require => Package['openssh-server'],
    }
  }

  file_line { 'Set strong ciphers':
    ensure  => present,
    path    => '/etc/ssh/sshd_config',
    match   => '^Ciphers',
    line    => "Ciphers ${ssh_strong_ciphers}",
    notify  => Service['sshd'],
    require => Package['openssh-server'],
  }

  file_line { 'Set SSH idle timeout interval':
    ensure  => present,
    path    => '/etc/ssh/sshd_config',
    match   => '^# ClientAliveInterval',
    line    => "ClientAliveInterval ${ssh_idle_timeout}",
    notify  => Service['sshd'],
    require => Package['openssh-server'],
  }

  file_line { 'Set HMACs':
    ensure  => present,
    path    => '/etc/ssh/sshd_config',
    match   => '^MACs',
    line    => "MACs ${ssh_strong_hmacs}",
    notify  => Service['sshd'],
    require => Package['openssh-server'],
  }

  if $ssh_only_ssh_2 == true {
    file_line { 'Allow only SSH 2':
      ensure  => present,
      path    => '/etc/ssh/sshd_config',
      match   => '^Protocol',
      line    => 'Protocol 2',
      notify  => Service['sshd'],
      require => Package['openssh-server'],
    }
  }

  if $ssh_disable_x11_forwarding == true {
    file_line { 'Disabled X11 forwarding':
      ensure  => present,
      path    => '/etc/ssh/sshd_config',
      match   => '^X11Forwarding',
      line    => 'X11Forwarding no',
      notify  => Service['sshd'],
      require => Package['openssh-server'],
    }
  }

  if $ssh_disable_empty_password == true {
    file_line { 'Disable empty password':
      ensure  => present,
      path    => '/etc/ssh/sshd_config',
      match   => '^PermitEmptyPasswords',
      line    => 'PermitEmptyPasswords no',
      notify  => Service['sshd'],
      require => Package['openssh-server'],
    }
  }

  file_line { 'This ensures a user login will be terminated as soon as the ClientAliveCountMax is reached':
    ensure  => present,
    path    => '/etc/ssh/sshd_config',
    match   => '^ClientAliveCountMax',
    line    => "ClientAliveCountMax ${ssh_client_alive_count_max}",
    notify  => Service['sshd'],
    require => Package['openssh-server'],
  }

  if $ssh_disable_user_env == true {
    file_line { 'SSH environment options potentially allow users to bypass access restriction in some configurations':
      ensure  => present,
      path    => '/etc/ssh/sshd_config',
      match   => '^PermitUserEnvironment',
      line    => 'PermitUserEnvironment no',
      notify  => Service['sshd'],
      require => Package['openssh-server'],
    }
  }

}