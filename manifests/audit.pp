class linux_hardening::audit (

  $audit_access                = true,
  $audit_actions               = true,
  $audit_networkconfig         = true,
  $audit_usergroup             = true,
  $audit_time                  = true,
  $audit_delete                = true,
  $audit_export                = true,
  $audit_immutable             = true,
  $audit_logins                = true,
  $audit_mac_policy            = true,
  $audit_modules               = true,
  $audit_perm_mod              = true,
  $audit_privileged            = true,
  $audit_session               = true,
  $audit_time_change           = true,
  $audit_admin_action_low_disk = true,
  $audit_action_low_disk       = true,
  $audit_flush_priority        = true,
  $audit_syslog                = true,
  ) {

  package { 'audit':
    ensure   => 'latest',
    provider => 'yum',
  }

  service { 'auditd':
    ensure  => 'running',
    enable  => true,
    require =>  Package['audit'],
  }

  # Audit rules configuration
  file {
    default:
      owner   => root,
      group   => root,
      require => Service['auditd'],
    ;
    '/etc/audit/rules.d/access.rules':
      ensure => bool2str($audit_access, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/access.rules',
    ;
    '/etc/audit/rules.d/actions.rules':
      ensure => bool2str($audit_actions, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/actions.rules',
    ;
    '/etc/audit/rules.d/audit_networkconfig.rules':
      ensure => bool2str($audit_networkconfig, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/audit_networkconfig.rules',
    ;
    '/etc/audit/rules.d/audit_usergroup.rules':
      ensure => bool2str($audit_usergroup, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/audit_usergroup.rules',
    ;
    '/etc/audit/rules.d/audit_time.rules':
      ensure => bool2str($audit_time, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/audit_time.rules',
    ;
    '/etc/audit/rules.d/delete.rules':
      ensure => bool2str($audit_delete, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/delete.rules',
    ;
    '/etc/audit/rules.d/export.rules':
      ensure => bool2str($audit_export, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/export.rules',
    ;
    '/etc/audit/rules.d/immutable.rules':
      ensure => bool2str($audit_immutable, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/immutable.rules',
    ;
    '/etc/audit/rules.d/logins.rules':
      ensure => bool2str($audit_logins, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/logins.rules',
    ;
    '/etc/audit/rules.d/mac_policy.rules':
      ensure => bool2str($audit_mac_policy, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/mac_policy.rules',
    ;
    '/etc/audit/rules.d/modules.rules':
      ensure => bool2str($audit_modules, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/modules.rules',
    ;
    '/etc/audit/rules.d/perm_mod.rules':
      ensure => bool2str($audit_perm_mod, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/perm_mod.rules',
    ;
    '/etc/audit/rules.d/privileged.rules':
      ensure => bool2str($audit_privileged, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/privileged.rules',
    ;
    '/etc/audit/rules.d/session.rules':
      ensure => bool2str($audit_session, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/session.rules',
    ;
    '/etc/audit/rules.d/time_change.rules':
      ensure => bool2str($audit_time_change, 'present', 'absent'),
      source => 'puppet:///modules/linux_hardening/audit/time_change.rules',
    ;
  }

  file_line { 'Configure auditd admin_space_left action on low disk space':
    ensure  => bool2str($audit_admin_action_low_disk, 'present', 'absent'),
    path    => '/etc/audit/auditd.conf',
    match   => '^admin_space_left_action =',
    line    => 'admin_space_left_action = single',
    require => Service['auditd'],
  }

  file_line { 'Configure audit space_left action on low disk space':
    ensure  => bool2str($audit_action_low_disk, 'present', 'absent'),
    path    => '/etc/audit/auditd.conf',
    match   => '^space_left_action =',
    line    => 'space_left_action = email',
    require => Service['auditd'],
  }

  file_line { 'Configure auditd flush priority':
    ensure  => bool2str($audit_flush_priority, 'present', 'absent'),
    path    => '/etc/audit/auditd.conf',
    match   => '^flush =',
    line    => 'flush = data',
    require => Service['auditd'],
  }

  file_line { 'Configure auditd to use audispd syslog plugin':
    ensure  => bool2str($audit_syslog, 'present', 'absent'),
    path    => '/etc/audisp/plugins.d/syslog.conf',
    match   => '^active =',
    line    => 'active = yes',
    require => Service['auditd'],
  }

}
