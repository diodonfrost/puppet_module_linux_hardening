# Class: linux_hardening
# ===========================
#
# Full description of class linux_hardening here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'linux_hardening':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class linux_hardening(
  # SELinux config
  $selinux_mode                 = 'enforcing',
  $selinux_boolean_execstack    = false,
  $selinux_boolean_execheap     = false,
  $selinux_boolean_virt_use_usb = false,
  $selinux_boolean_deny_ptrace  = true,

  # Audit config
  $audit_access                 = true,
  $audit_actions                = true,
  $audit_networkconfig          = true,
  $audit_usergroup              = true,
  $audit_time                   = true,
  $audit_delete                 = true,
  $audit_export                 = true,
  $audit_immutable              = true,
  $audit_logins                 = true,
  $audit_mac_policy             = true,
  $audit_modules                = true,
  $audit_perm_mod               = true,
  $audit_privileged             = true,
  $audit_session                = true,
  $audit_time_change            = true,
  $audit_admin_action_low_disk  = true,
  $audit_action_low_disk        = true,
  $audit_flush_priority         = true,
  $audit_syslog                 = true,

  # Filesystem config hardening
  $filesystem_logfiles_perm     = '0600',
  $filesystem_hidden_process    = true,

  # Linux sysctl kernel hardening
  $kernel_base_ipv4_net_sysctl  = [ 0 ],
  $kernel_adv_ipv4_net_sysctl   = [ 1 ],
  $kernel_ipv6_disabled         = [ 1 ],
  $kernel_base_ipv6_net_sysctl  = [ 0 ],
  $kernel_adv_ipv6_net_sysctl   = [ 1 ],
  $kernel_sysrq                 = [ 0 ],
  $kernel_fs_suid_dumpable      = [ 0 ],
  $kernel_kptr_restrict         = [ 1 ],
  $kernel_dmesg_restrict        = [ 1 ],
  $kernel_perf_event_max_rate   = [ 1 ],
  $kernel_perf_cpu_time_max     = [ 1 ],
  $kernel_pid_max               = [ 65536 ],
  $kernel_perf_event_paranoid   = [ 2 ],
  $kernel_randomize_va_space    = [ 2 ],
  $kernel_vm_mmap_min_addr      = [ 65536 ],

  # Package for hardening system
  $package_libreswan            = true,
  $package_chrony               = true,
  $package_screen               = false,

  # Hardening PAM
  $pam_login_defs               = true,
  $pam_useradd                  = true,
  $pam_pwdquality               = true,
  $pam_system_auth              = false,
  $pam_password_auth            = false,
  $pam_passwd                   = false,

  # Hardening sshd
  $ssh_banner                  = true,
  $ssh_strong_ciphers          = 'aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc,aes192-cbc,aes256-cbc',
  $ssh_idle_timeout            = '900',
  $ssh_strong_hmacs            = 'hmac-sha2-512,hmac-sha2-256,hmac-sha1',
  $ssh_only_ssh_2              = true,
  $ssh_disable_x11_forwarding  = true,
  $ssh_disable_empty_password  = true,
  $ssh_client_alive_count_max  = '0',
  $ssh_disable_user_env        = true,

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
    kernel_base_ipv4_net_sysctl => $kernel_base_ipv4_net_sysctl,
    kernel_adv_ipv4_net_sysctl  => $kernel_adv_ipv4_net_sysctl,
    kernel_ipv6_disabled        => $kernel_ipv6_disabled,
    kernel_base_ipv6_net_sysctl => $kernel_base_ipv6_net_sysctl,
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

  class { 'linux_hardening::packages':
    package_libreswan => $package_libreswan,
    package_chrony    => $package_chrony,
    package_screen    => $package_screen,
  }

  class { 'linux_hardening::pam':
    pam_login_defs    => $pam_login_defs,
    pam_useradd       => $pam_useradd,
    pam_pwdquality    => $pam_pwdquality,
    pam_system_auth   => $pam_system_auth,
    pam_password_auth => $pam_password_auth,
    pam_passwd        => $pam_passwd,
  }

  class { 'linux_hardening::sshd':
    ssh_banner                 => $ssh_banner,
    ssh_strong_ciphers         => $ssh_strong_ciphers,
    ssh_idle_timeout           => $ssh_idle_timeout,
    ssh_strong_hmacs           => $ssh_strong_hmacs,
    ssh_only_ssh_2             => $ssh_only_ssh_2,
    ssh_disable_x11_forwarding => $ssh_disable_x11_forwarding,
    ssh_disable_empty_password => $ssh_disable_empty_password,
    ssh_client_alive_count_max => $ssh_client_alive_count_max,
    ssh_disable_user_env       => $ssh_disable_user_env,

  }
}
