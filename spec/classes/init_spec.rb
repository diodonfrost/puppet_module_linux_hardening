require 'spec_helper'
describe 'linux_hardening' do
  context 'with default values for all parameters' do
    it { should contain_class('linux_hardening') }
  end
end
