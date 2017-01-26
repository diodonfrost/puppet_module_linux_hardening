class linux_hardening::pam (
  $pam_login_defs    = true,
  $pam_useradd       = true,
  $pam_pwdquality    = true,
  $pam_system_auth   = false,
  $pam_password_auth = false,
  $pam_passwd        = false,
)  {

  if $pam_login_defs == true {
    file {'/etc/login.defs':
      content => template('linux_hardening/pam/login.defs'),
      owner   => root,
      group   => root,
    }
  }

  if $pam_useradd == true {
    file {'/etc/default/useradd':
      content => template('linux_hardening/pam/useradd'),
      owner   => root,
      group   => root,
    }
  }

  if $pam_pwdquality == true {
    file {'/etc/default/pwquality.conf':
      content => template('linux_hardening/pam/pwquality.conf'),
      owner   => root,
      group   => root,
    }
  }

  if $pam_system_auth == true {
    file {'/etc/pam.d/system-auth':
      content => template('linux_hardening/pam/system-auth'),
      owner   => root,
      group   => root,
    }
  }

  if $pam_password_auth == true {
    file {'/etc/pam.d/password-auth':
      content => template('linux_hardening/pam/password-auth'),
      owner   => root,
      group   => root,
    }
  }

  if $pam_passwd == true {
    file {'/etc/pam.d/passwd':
      content => template('linux_hardening/pam/passwd'),
      owner   => root,
      group   => root,
    }
  }

}