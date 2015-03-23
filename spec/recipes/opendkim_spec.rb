require_relative '../spec_helper'

describe 'email::opendkim' do
  subject { ChefSpec::SoloRunner.new.converge(described_recipe) }

  before do
    allow(Chef::EncryptedDataBagItem).to receive(:load).with('domainkeys', 'example.com')
      .and_return({'private_key' => 'some_encrypted_shit'})
  end

  it { is_expected.to install_package 'opendkim' }
  it { is_expected.to enable_service 'opendkim' }
  it { is_expected.to create_directory '/etc/opendkim/keys' }
  it { is_expected.to create_template('/etc/opendkim.conf') }
  it { is_expected.to render_file('/etc/opendkim/keys/example.com.key').with_content('some_encrypted_shit') }
  it { is_expected.to render_file('/etc/opendkim/KeyTable')
      .with_content('mail._domainkey.example.com example.com:mail:/etc/opendkim/keys/example.com.key') }
  it { is_expected.to render_file('/etc/opendkim/SigningTable')
      .with_content('example.com mail._domainkey.example.com') }
  it { is_expected.to render_file('/etc/opendkim/TrustedHosts').with_content('127.0.0.0/8')}
end
