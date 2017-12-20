# Class: linux_hardening
# ===========================
#
# This class improved security on Linux
#
# Parameters
# ----------
#
#
### SELINUX
#
#
# [*selinux_mode*]
#  Set mod selinux: enforcing, permissive or disabled.
#
#  Default:  enforcing
#
# [*selinux_boolean_execstack*]
#  Disable selinuxuser to execstack.
#
#  Default:  false
#
# [*boolean_execheap]
#  Disable selinuxuser to execheap.
#
#  Default:  false
#
# [*selinux_boolean_virt_use_usb*]
#  Disable virt to use usb.
#
#  Default:  false
#
# [*selinux_boolean_deny_ptrace*]
#  Allow deny to ptrace.
#
#  Default:  true
#
#
### AUDIT
#
#
# [*audit_access*]
#  Log audit access.
#
#  Default:  true
#
# [*audit_actions*]
#  Log audit action.
#
#  Default:  true
#
# [*audit_networkconfig*]
#  Record events that modify network.
#
#  Default:  true
#
# [*audit_usergroup*]
#  Records events that modify on users and groups.
#
#  Default:  true
#
# [*audit_time*]
#  Records events that modify date information.
#
#  Default:  true
#
# [*audit_delete*]
#  Record events log modifications when deleting files or directory.
#
#  Default:  true
#
# [*audit_export*]
#  Record events modification when mount filesystem.
#
#  Default:  true
#
# [*audit_immutable*]
#  Set audit config unchangeable.
#
#  Default:  true
#
# [*audit_logins*]
#  Record events on logins.
#
#  Default:  true
#
# [*audit_mac_policy*]
#  Record events that modify policy SELinux.
#
#  Default:  true
#
# [*audit_modules*]
#  Record events on insmod, rmmod and modprobe.
#
#  Default:  true
#
# [*audit_perm_mod*]
#  Record events that modification permissions.
#
#  Default:  true
#
# [*audit_privileged*]
#  Record events on commande line privileges.
#
#  Default:  true
#
# [*audit_session*]
#  Record events on session with utmp, btmp and wtmp.
#
#  Default:  true
#
# [*audit_time_change*]
#  Record events that modify clock set time.
#
#  Default:  true
#
# [*audit_admin_action_low_disk*]
#  Configure auditd admin_space_left action on low disk space.
#
#  Default:  true
#
# [*audit_action_low_disk*]
#  Configure audit space_left action on low disk space.
#
#  Default:  true
#
# [*audit_flush_priority*]
#  Configure auditd flush priority.
#
#  Default:  true
#
# [*audit_syslog*]
#  Configure auditd to use audispd syslog plugin.
#
#  Default:  false
#
#
### FILESYSTEM
#
#
# [*filesystem_logfiles_perm*]
#  Set permissions on: /var/log/messages
#                      /var/log/secure
#                      /var/log/maillog
#                      /var/log/spooler
#                      /var/log/cron
#                      /var/log/boot.log
#
#  Default:  '0600'
#
#
### SYSCTL
#
#
# [*kernel_basic_ipv4_net_sysctl*]
#  Disable weak ipv4 configuration.
#
#  Default:  0
#
# [*kernel_adv_ipv4_net_sysctl*]
#  Improved advanced ipv4 network hardening.
#
#  Default: 1
#
# [*kernel_ipv6_disabled*]
#  Disable ipv6.
#
#  Default: 1
#
# [*kernel_weak_ipv6_net_sysctl*]
#  Disable weak ipv6 configuration.
#
#  Default:  0
#
# [*kernel_adv_ipv6_net_sysctl*]
#  Improved advanced ipv6 network hardening.
#
#  Default:  1
#
# [*kernel_sysrq*]
#  Enable sysreq.
#
#  Default:  0
#
# [*kernel_fs_suid_dumpable*]
#  Disable core dump kernel setuid.
#
#  Default:  0
#
# [*kernel_kptr_restrict*]
#  Cloak memory kernel address.
#
#  Default: 1
#
# [*kernel_dmesg_restrict*]
#  Restrict access of buffer dmesg.
#
#  Default:  1
#
# [*kernel_perf_event_max_rate*]
#  Restrict sub-system perf.
#
#  Default:  1
#
# [*$kernel_perf_cpu_time_max*]
#  Restrict sub-system perf.
#
#  Default:  1
#
# [*kernel_perf_event_paranoid*]
#  Restrict sub-system perf.
#
#  Default:  2
#
# [*kernel_pid_max*]
#  Improved number of pid max.
#
#  Default:  65536
#
# [*kernel_randomize_va_space*]
#  Randomize memorie address sapce.
#
#  Default:  2
#
# [*kernel_vm_mmap_min_addr*]
#  Set minimum virtual address.
#
#  Default 65535
#
#
### PACKAGES
#
#
#### PAM
#
# [*pam_pwquality_settings*]
#  Improved passwors strenght.
#
# [*pam_login_defs*]
#  Set timeout for incativity.
#
#### SSHD
#
# [*ssh_banner*]
# Set ssh banner.
#
#  Default:  true
#
# [*ssh_settings*]
#  Configure service sshd settings.
#
# Author
# -------
#
# Diodonfrost keres@protonmail.com
#
# Copyleft
# ---------
#
# Copyleft 2017.
#
class linux_hardening(
  # SELinux config
  $selinux_mode                  = 'enforcing',
  $selinux_boolean_execstack     = false,
  $selinux_boolean_execheap      = false,
  $selinux_boolean_virt_use_usb  = false,
  $selinux_boolean_deny_ptrace   = true,

  # Audit config
  $audit_access                  = true,
  $audit_actions                 = true,
  $audit_networkconfig           = true,
  $audit_usergroup               = true,
  $audit_time                    = true,
  $audit_delete                  = true,
  $audit_export                  = true,
  $audit_immutable               = true,
  $audit_logins                  = true,
  $audit_mac_policy              = true,
  $audit_modules                 = true,
  $audit_perm_mod                = true,
  $audit_privileged              = true,
  $audit_session                 = true,
  $audit_time_change             = true,
  $audit_admin_action_low_disk   = true,
  $audit_action_low_disk         = true,
  $audit_flush_priority          = true,
  $audit_syslog                  = false,

  # Filesystem config hardening
  $filesystem_logfiles_perm      = '0600',
  $filesystem_hidden_process     = true,

  # Linux sysctl kernel hardening
  $kernel_weak_ipv4_net_sysctl   = '0',
  $kernel_adv_ipv4_net_sysctl    = '1',
  $kernel_ipv6_disabled          = '1',
  $kernel_weak_ipv6_net_sysctl   = '0',
  $kernel_adv_ipv6_net_sysctl    = '1',
  $kernel_sysrq                  = '0',
  $kernel_fs_suid_dumpable       = '0',
  $kernel_kptr_restrict          = '1',
  $kernel_dmesg_restrict         = '1',
  $kernel_perf_event_max_rate    = '1',
  $kernel_perf_cpu_time_max      = '1',
  $kernel_pid_max                = '65536',
  $kernel_perf_event_paranoid    = '2',
  $kernel_randomize_va_space     = '2',
  $kernel_vm_mmap_min_addr       = '65536',

  # Package for hardening system
  $package_ntp_servers           = ['0.rhel.pool.ntp.org', '1.rhel.pool.ntp.org', '2.rhel.pool.ntp.org', '3.rhel.pool.ntp.org'],

  # Hardening PAM
  $pam_pwquality_settings        = { 'dcredit' => '-1',
                                     'minlen'  => '7',
                                     'ucredit' => '-1',
                                     'lcredit' => '-1',
                                     'ocredit' => '-1',
                                     'difok'   => '7', },
  $pam_login_defs                = { 'PASS_MAX_DAYS'  => '90',
                                     'PASS_MIN_DAYS'  => '1',
                                     'ENCRYPT_METHOD' => 'SHA512', },

  # Hardening sshd
  $ssh_banner                    = true,
  Hash[String, Any]$ssh_settings = { 'Ciphers'               => 'aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc,aes192-cbc,aes256-cbc',
                                     'ClientAliveInterval'   => '900',
                                     'MACs'                  => 'hmac-sha2-512,hmac-sha2-256,hmac-sha1',
                                     'Protocol'              => '2',
                                     'X11Forwarding'         => 'no',
                                     'PermitEmptyPasswords'  => 'no',
                                     'ClientAliveCountMax'   => '0',
                                     'PermitUserEnvironment' => 'no',
                                     'PermitRootLogin'       => 'no', },

) {
  class { 'linux_hardening::selinux':
    selinux_mode                 => $selinux_mode,
    selinux_boolean_execstack    => $selinux_boolean_execstack,
    selinux_boolean_execheap     => $selinux_boolean_execheap,
    selinux_boolean_virt_use_usb => $selinux_boolean_virt_use_usb,
    selinux_boolean_deny_ptrace  => $selinux_boolean_deny_ptrace,
  }

  class { 'linux_hardening::audit':
    audit_access                => $audit_access ,
    audit_actions               => $audit_actions,
    audit_networkconfig         => $audit_networkconfig ,
    audit_usergroup             => $audit_usergroup,
    audit_time                  => $audit_time,
    audit_delete                => $audit_delete,
    audit_export                => $audit_export,
    audit_immutable             => $audit_immutable,
    audit_logins                => $audit_logins,
    audit_mac_policy            => $audit_mac_policy,
    audit_modules               => $audit_modules,
    audit_perm_mod              => $audit_perm_mod,
    audit_privileged            => $audit_privileged,
    audit_session               => $audit_session,
    audit_time_change           => $audit_time_change,
    audit_admin_action_low_disk => $audit_admin_action_low_disk,
    audit_action_low_disk       => $audit_action_low_disk,
    audit_flush_priority        => $audit_flush_priority,
    audit_syslog                => $audit_syslog,
  }

  class { 'linux_hardening::filesystem':
    filesystem_logfiles_perm  => $filesystem_logfiles_perm,
    filesystem_hidden_process => $filesystem_hidden_process,
  }

  class { 'linux_hardening::kernel':
    kernel_weak_ipv4_net_sysctl => $kernel_weak_ipv4_net_sysctl,
    kernel_adv_ipv4_net_sysctl  => $kernel_adv_ipv4_net_sysctl,
    kernel_ipv6_disabled        => $kernel_ipv6_disabled,
    kernel_weak_ipv6_net_sysctl => $kernel_weak_ipv6_net_sysctl,
    kernel_adv_ipv6_net_sysctl  => $kernel_adv_ipv6_net_sysctl,
    kernel_sysrq                => $kernel_sysrq,
    kernel_fs_suid_dumpable     => $kernel_fs_suid_dumpable,
    kernel_kptr_restrict        => $kernel_kptr_restrict,
    kernel_dmesg_restrict       => $kernel_dmesg_restrict,
    kernel_perf_event_max_rate  => $kernel_perf_event_max_rate,
    kernel_perf_cpu_time_max    => $kernel_perf_cpu_time_max,
    kernel_pid_max              => $kernel_pid_max,
    kernel_perf_event_paranoid  => $kernel_perf_event_paranoid,
    kernel_randomize_va_space   => $kernel_randomize_va_space,
    kernel_vm_mmap_min_addr     => $kernel_vm_mmap_min_addr,
  }

  class { 'linux_hardening::services::ntp':
    package_ntp_servers => $package_ntp_servers,
  }

  class { 'linux_hardening::pam':
    pam_pwquality_settings => $pam_pwquality_settings,
    pam_login_defs         => $pam_login_defs,
  }

  class { 'linux_hardening::services::ssh':
    ssh_banner   => $ssh_banner,
    ssh_settings => $ssh_settings,
  }

  class { 'linux_hardening::services::aide':}

}
