
class linux_hardening::selinux (
  $selinux_mode                 = 'enforcing',
  $selinux_boolean_execstack    = false,
  $selinux_boolean_execheap     = false,
  $selinux_boolean_virt_use_usb = false,
  $selinux_boolean_deny_ptrace  = true,
) {

# A MODIFIER POUR LE MODE PERMISSIF
  file_line { 'Selinux config':
    ensure => present,
    path   => '/etc/selinux/config',
    match  => '^SELINUX=',
    line   => "SELINUX=${selinux_mode}",
    }

  # Set SELinux boolean
  selboolean {
    default:
      persistent => true,
    ;
    # Deny selinuxuser to execstack
    'Set boolean execstack':
      name  => 'selinuxuser_execstack',
      value => bool2str($selinux_boolean_execstack, 'on', 'off'),
    ;
    # Deny selinuxuser to execstack
    'Set boolean execheap':
      name  => 'selinuxuser_execheap',
      value => bool2str($selinux_boolean_execheap, 'on', 'off'),
    ;
    # Deny virt to use usb
    'Set boolean virt_use_usb':
      name  => virt_use_usb,
      value => bool2str($selinux_boolean_virt_use_usb, 'on', 'off'),
    ;
    # Deny ptrace
    'Set boolean deny_ptrace':
      name  => deny_ptrace,
      value => bool2str($selinux_boolean_deny_ptrace, 'on', 'off'),
    ;
  }
}

