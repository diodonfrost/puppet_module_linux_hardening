# hardening audit
class linux_hardening::audit (

  Boolean $audit_access,
  Boolean $audit_actions,
  Boolean $audit_networkconfig,
  Boolean $audit_usergroup,
  Boolean $audit_time,
  Boolean $audit_delete,
  Boolean $audit_export,
  Boolean $audit_immutable,
  Boolean $audit_logins,
  Boolean $audit_mac_policy,
  Boolean $audit_modules,
  Boolean $audit_perm_mod,
  Boolean $audit_privileged,
  Boolean $audit_session,
  Boolean $audit_time_change,
  Boolean $audit_admin_action_low_disk,
  Boolean $audit_action_low_disk,
  Boolean $audit_flush_priority,
  Boolean $audit_syslog,
  ) {

  if $facts['virtual'] != 'docker' {
    package { 'audit':
      ensure   => present,
    }

    service { 'auditd':
      ensure  => running,
      enable  => true,
      require =>  Package['audit'],
    }

    # systemctl restart auditd doesn't work, instead of use service auditd restart.
    exec { 'service auditd restart':
      path        => '/usr/local/bin/:/bin/:/usr/sbin/',
      provider    => 'shell',
      refreshonly => true,
    }

    # Configure auditd to use audispd's syslog plugin.
    ini_setting {'use audit with syslog':
      ensure            => present,
      key_val_separator => ' = ',
      path              => '/etc/audisp/plugins.d/syslog.conf',
      setting           => 'active',
      value             => 'yes',
      notify            => Exec['service auditd restart'],
    }

    # Configure logrotate daily.
    file_line { 'enable logrotate all days':
      ensure => present,
      path   => '/etc/logrotate.conf',
      match  => '^daily',
      line   => 'daily',
    }

    # Audit rules configuration.
    file {
      default:
        owner  => root,
        group  => root,
        notify => Exec['service auditd restart'],
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
  }
}
