require 'spec_helper_acceptance'

# Set role to apply
describe 'roles class' do
  let(:manifest) do
    <<-EOS
      include linux_hardening
    EOS
  end

  # Puppet apply manifest
  it 'should run without errors' do
    result = apply_manifest(manifest, catch_failures: true)
    expect(@result.exit_code).to eq 2
  end

  # Test ntpd is installed
  describe package("ntp") do
    it { is_expected.to be_installed }
  end

  # Test ntpd is running and enable
  describe service("ntpd") do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  # Test audit service
  describe service("auditd") do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  # Test indempotence
  it 'should run a second time without changes' do
    result = apply_manifest(manifest, catch_failures: true)
    expect(@result.exit_code).to eq 0
  end
end
