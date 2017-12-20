# Hardening package
class linux_hardening::services::ntp(
  $package_ntp_servers,
) {

  # Set multiple ntp servers.
  class { '::ntp':
    servers => [ '0.rhel.pool.ntp.org', '1.rhel.pool.ntp.org', '2.rhel.pool.ntp.org', '3.rhel.pool.ntp.org'],
  }
}
