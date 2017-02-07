
class linux_hardening::kernel(
  $kernel_weak_ipv4_net_sysctl  = '0',
  $kernel_adv_ipv4_net_sysctl   = '1',
  $kernel_ipv6_disabled         = '1',
  $kernel_weak_ipv6_net_sysctl  = '0',
  $kernel_adv_ipv6_net_sysctl   = '1',
  $kernel_sysrq                 = '0',
  $kernel_fs_suid_dumpable      = '0',
  $kernel_kptr_restrict         = '1',
  $kernel_dmesg_restrict        = '1',
  $kernel_perf_event_max_rate   = '1',
  $kernel_perf_cpu_time_max     = '1',
  $kernel_pid_max               = '65536',
  $kernel_perf_event_paranoid   = '2',
  $kernel_randomize_va_space    = '2',
  $kernel_vm_mmap_min_addr      = '65536',
  ) {

  # Sysctl hardening
  sysctl { 'net.ipv4.ip_forward': value => '$kernel_weak_ipv4_net_sysctl' }
  sysctl { 'net.ipv4.conf.all.send_redirects': value => '$kernel_weak_ipv4_net_sysctl' }
  sysctl { 'net.ipv4.conf.default.send_redirects': value => '$kernel_weak_ipv4_net_sysctl' }
  sysctl { 'net.ipv4.conf.all.accept_source_route': value => '$kernel_weak_ipv4_net_sysctl' }
  sysctl { 'net.ipv4.conf.default.accept_source_route': value => '$kernel_weak_ipv4_net_sysctl' }
  sysctl { 'net.ipv4.conf.all.accept_redirects': value => '$kernel_weak_ipv4_net_sysctl' }
  sysctl { 'net.ipv4.conf.all.secure_redirects': value => '$kernel_weak_ipv4_net_sysctl' }
  sysctl { 'net.ipv4.conf.default.accept_redirects': value => '$kernel_weak_ipv4_net_sysctl' }
  sysctl { 'net.ipv4.conf.default.secure_redirects': value => '$kernel_weak_ipv4_net_sysctl' }
  sysctl { 'net.ipv6.conf.all.router_solicitations': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.default.router_solicitations': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.all.accept_ra_rtr_pref': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.default.accept_ra_rtr_pref': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.all.accept_ra_pinfo': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.default.accept_ra_pinfo': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.all.accept_ra_defrtr': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.default.accept_ra_defrtr': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.all.autoconf': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.default.autoconf': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.all.accept_redirects': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.default.accept_redirects': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.all.accept_source_route': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.default.accept_source_route': value => '$kernel_weak_ipv6_net_sysctl' }
  sysctl { 'kernel.sysrq': value => '$kernel_sysrq' }
  sysctl { 'fs.suid_dumpable': value => '$kernel_fs_suid_dumpable' }
  sysctl { 'net.ipv4.conf.all.rp_filter': value => '$kernel_adv_ipv4_net_sysctl ' }
  sysctl { 'net.ipv4.conf.default.rp_filter': value => '$kernel_adv_ipv4_net_sysctl ' }
  sysctl { 'net.ipv4.conf.all.log_martians': value => '$kernel_adv_ipv4_net_sysctl ' }
  sysctl { 'net.ipv4.tcp_rfc1337': value => '$kernel_adv_ipv4_net_sysctl ' }
  sysctl { 'net.ipv4.icmp_ignore_bogus_error_responses': value => '$kernel_adv_ipv4_net_sysctl ' }
  sysctl { 'net.ipv4.icmp_echo_ignore_broadcasts': value => '$kernel_adv_ipv4_net_sysctl ' }
  sysctl { 'net.ipv4.tcp_syncookies': value => '$kernel_adv_ipv4_net_sysctl ' }
  sysctl { 'net.ipv6.conf.all.max_addresses': value => '$kernel_adv_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.default.max_addresses': value => '$kernel_adv_ipv6_net_sysctl' }
  sysctl { 'net.ipv6.conf.all.disable_ipv6': value => '$kernel_ipv6_enable' }
  sysctl { 'kernel.kptr_restrict': value => '$kernel_kptr_restrict' }
  sysctl { 'kernel.dmesg_restrict': value => '$kernel_dmesg_restrict' }
  sysctl { 'kernel.perf_event_max_sample_rate': value => '$kernel_perf_event_max_rate' }
  sysctl { 'kernel.perf_cpu_time_max_percent': value => '$kernel_perf_cpu_time_max' }
  sysctl { 'vm.mmap_min_addr': value => '$kernel_vm_mmap_min_addr' }
  sysctl { 'kernel.pid_max': value => '$kernel_pid_max' }
  sysctl { 'kernel.perf_event_paranoid': value => '$kernel_perf_event_paranoid' }
  sysctl { 'kernel.randomize_va_space': value => '$kernel_randomize_va_space' }
  }
