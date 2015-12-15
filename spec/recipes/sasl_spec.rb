require_relative '../spec_helper'

describe 'email::sasl' do


  before do
    allow(Chef::DataBag).to receive(:load).with('sasl_secrets')
                             .and_return({example: ''})
    allow(Chef::EncryptedDataBagItem).to receive(:load).with('sasl_secrets', :example)
                                          .and_return({'relayhost' => 'smtp.example.com',
                                                       'username'  => 'example',
                                                       'password'  => 'crypted_example'})
  end

  context 'debian' do
    subject do ChefSpec::SoloRunner.new do |node|
                 node.set[:email][:sasl] = true
               end.converge(described_recipe)
    end
    it { is_expected.to install_package 'libsasl2-modules' }
    it_behaves_like 'sasl tuner'
  end

  context 'redhat' do
    subject do ChefSpec::SoloRunner.new(platform: 'centos', version: '6.5') do |node|
                 node.set[:email][:sasl] = true
               end.converge(described_recipe)
    end
    it { is_expected.to install_package 'cyrus-sasl-plain' }
    it_behaves_like 'sasl tuner'
  end

end
