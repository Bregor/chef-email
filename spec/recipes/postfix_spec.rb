require_relative '../spec_helper'

describe 'email::postfix' do
  subject do ChefSpec::SoloRunner.new do |node|
               node.set[:email][:virtual_mailbox_domains] = ['example.com']
             end.converge(described_recipe)
  end

  it { is_expected.to install_package 'postfix' }
  it { is_expected.to enable_service 'postfix' }
  it { is_expected.to create_directory '/var/mail/vhosts' }
  it { is_expected.to render_file('/etc/postfix/main.cf')
                       .with_content('virtual_mailbox_domains = example.com') }

  context 'without DKIM' do
    subject do ChefSpec::SoloRunner.new do |node|
                 node.set[:email][:dkim] = false
               end.converge(described_recipe)
    end

    it { is_expected.not_to render_file('/etc/postfix/main.cf').with_content('smtpd_milters = inet:localhost:8891') }
  end

  context 'without sender restrictions' do
    subject do ChefSpec::SoloRunner.new do |node|
                 node.set[:email][:restricted] = false
               end.converge(described_recipe)
    end

    it { is_expected.not_to render_file('/etc/postfix/main.cf')
                             .with_content('smtpd_sender_restrictions = reject_unknown_sender_domain') }
  end

  context 'with empty array in node[:email][:postfix]' do
    subject do ChefSpec::SoloRunner.new do |node|
                 node.set[:email][:postfix][:emptykey] = []
               end.converge(described_recipe)
    end

    it { is_expected.not_to render_file('/etc/postfix/main.cf').with_content('emptykey') }
  end

end
