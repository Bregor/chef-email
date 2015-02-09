require_relative '../spec_helper'

describe 'email::default' do
  subject { ChefSpec::SoloRunner.new.converge(described_recipe) }

  before do
    allow(Chef::EncryptedDataBagItem).to receive(:load).with('domainkeys', 'example_com')
      .and_return({'private_key' => 'some_encrypted_shit'})
  end

  it { is_expected.to include_recipe 'email::opendkim' }
  it { is_expected.to include_recipe 'email::postfix' }

  context 'without DKIM' do
    subject do ChefSpec::SoloRunner.new do |node|
        node.set[:email][:dkim] = false
      end.converge(described_recipe)
    end

    it { is_expected.not_to include_recipe 'email::opendkim' }
    it { is_expected.to include_recipe 'email::postfix' }
  end
end
