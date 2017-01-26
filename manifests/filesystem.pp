
class linux_hardening::filesystem (
  $filesystem_logfiles_perm  = '0600',
  $filesystem_hidden_process = true,
  ) {

  # Set permission on filelog
  file { ['/var/log/messages', '/var/log/secure', '/var/log/maillog', '/var/log/spooler', '/var/log/cron', '/var/log/boot.log']:
    mode => $filesystem_logfiles_perm,
  }

  # Hiding processes from other users

  file_line { 'insert/update fstab configuation block in /etc/fstab for hidden process':
    ensure => bool2str($filesystem_hidden_process, 'present', 'absent'),
    path   => '/etc/fstab',
    match  => '^proc',
    line   => 'proc /proc proc defaults,hidepid=2 0 0',
    notify => Exec['remount proc'],
  }

  # Remount proc when fstab proc is modified
  exec { 'remount proc':
    path        => ['/bin', '/usr/bin', '/sbin', '/usr/sbin',],
    command     => 'mount -o remount,rw,hidepid=2 /proc',
    refreshonly => true,
  }

}
