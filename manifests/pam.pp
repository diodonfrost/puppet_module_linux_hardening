# Hardening pam
class linux_hardening::pam (
  Hash[String, Any] $pam_pwquality_settings,
  Hash[String, Any] $pam_login_defs,
)  {

  # Improved default quality password.
  $pam_pwquality_settings.each |$key, $val| {
    ini_setting { "hardening password quality ${key}":
      ensure            => present,
      key_val_separator => ' = ',
      path              => '/etc/security/pwquality.conf',
      setting           => $key,
      value             => $val,
    }
  }

  # Set Password Hashing Algorithm in /etc/login.defs.
  $pam_login_defs.each |$key, $val| {
    ini_setting { "login defs config ${key}":
      ensure            => present,
      key_val_separator => ' ',
      path              => '/etc/login.defs',
      setting           => $key,
      value             => $val,
    }
  }

  # Set account expiration following inactivity.
  ini_setting { 'useradd definition':
    ensure            => present,
    key_val_separator => '=',
    path              => '/etc/default/useradd',
    setting           => 'INACTIVE',
    value             => '90',
  }

  pam { 'Set deny for failed Password attempts in auth and system-auth file':
    ensure           => present,
    service          => 'system-auth',
    type             => 'auth',
    control          => 'required',
    control_is_param => true,
    module           => 'pam_faillock.so',
    arguments        => ['preauth', 'silent', 'deny=6', 'unlock_time=1800', 'fail_interval=900'],
    position         => 'before *[type="auth" and module="pam_unix.so"]',
  }

  pam { 'Set deny for failed Password attempts in auth and password-auth file':
    ensure           => present,
    service          => 'password-auth',
    type             => 'auth',
    control          => 'required',
    control_is_param => true,
    module           => 'pam_faillock.so',
    arguments        => ['preauth', 'silent', 'deny=6', 'unlock_time=1800', 'fail_interval=900'],
    position         => 'before *[type="auth" and module="pam_unix.so"]',
  }
  pam {'Set deny for failed Password attempts in auth,default-die and system-auth file':
    ensure           => present,
    service          => 'system-auth',
    type             => 'auth',
    control          => '[default=die]',
    control_is_param => true,
    module           => 'pam_faillock.so',
    arguments        => ['authfail', 'deny=6', 'unlock_time=1800', 'fail_interval=900'],
    position         => 'after *[type="auth" and module="pam_unix.so"]',
  }

  pam {'Set deny for failed Password attempts in auth,default-die and password-auth file':
    ensure           => present,
    service          => 'password-auth',
    type             => 'auth',
    control          => '[default=die]',
    control_is_param => true,
    module           => 'pam_faillock.so',
    arguments        => ['authfail', 'deny=6', 'unlock_time=1800', 'fail_interval=900'],
    position         => 'after *[type="auth" and module="pam_unix.so"]',
  }

  pam {'Set require system-auth':
    ensure   => present,
    service  => 'system-auth',
    type     => 'account',
    control  => 'required',
    module   => 'pam_faillock.so',
    position => 'before *[type="account" and module="pam_unix.so"]',
  }

  pam {'Set require password-auth':
    ensure   => present,
    service  => 'password-auth',
    type     => 'account',
    control  => 'required',
    module   => 'pam_faillock.so',
    position => 'before *[type="account" and module="pam_unix.so"]',
  }

  # Doesn't allow user to reuse recent passwords.
  pam { 'pam_unix password recent reuse':
    ensure    => present,
    service   => 'system-auth',
    type      => 'password',
    control   => 'sufficient',
    module    => 'pam_unix.so',
    arguments => ['sha512', 'shadow', 'try_first_pass', 'use_authtok', 'remember=4'],
  }

  pam { 'pam_pwhistory password recent reuse':
    ensure    => present,
    service   => 'system-auth',
    type      => 'password',
    control   => 'requisite',
    module    => 'pam_pwhistory.so',
    arguments => ['try_first_pass', 'local_users_only', 'retry=3', 'authtok_type=', 'remember=4'],
  }

  # Prevent Log In to Accounts With Empty Password
  file_line { 'delete nullok':
    ensure => absent,
    path   => '/etc/pam.d/system-auth',
    match  => '/nullok/',
    line   => '',
  }
}