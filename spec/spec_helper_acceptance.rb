

require 'beaker-rspec'

logger.error('LOADED Monitoring Spec Acceptance Helper')

# Install Puppet on all hosts
install_puppet_agent_on(hosts, options)

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  c.formatter = :documentation

  c.before :suite do
    # Install module to all hosts
    hosts.each do |host|
      install_dev_puppet_module_on(host, source: module_root, module_name: 'linux_hardening',
                                         target_module_path: '/opt/puppetlabs/puppet/modules')

      # Install dependencies
      on(host, puppet('module', 'install', 'puppetlabs-stdlib'))
      on(host, puppet('module', 'install', 'puppetlabs-concat'))
      on(host, puppet('module', 'install', 'puppetlabs-inifile'))
      on(host, puppet('module', 'install', 'thias-sysctl'))
      on(host, puppet('module', 'install', 'herculesteam-augeasproviders_core'))
      on(host, puppet('module', 'install', 'herculesteam-augeasproviders_pam'))
      on(host, puppet('module', 'install', 'puppetlabs-ntp'))

      # Add more setup code as needed
    end
  end
  shared_examples 'a idempotent resource' do
    it 'applies with no errors' do
      apply_manifest(manifest, catch_failures: true)
    end
    it 'applies a second time without changes', :skip_pup_5016 do
      apply_manifest(manifest, catch_changes: true)
    end
  end
end
