require_relative '../spec_helper'

describe 'email::sasl' do
  subject do ChefSpec::SoloRunner.new do |node|
               node.set[:email][:sasl] = true
             end.converge(described_recipe)
  end

  before do
    allow(Chef::DataBag).to receive(:load).with('sasl_secrets')
                             .and_return({example: ''})
    allow(Chef::EncryptedDataBagItem).to receive(:load).with('sasl_secrets', :example)
                                          .and_return({'relayhost' => 'smtp.example.com',
                                                       'username'  => 'example',
                                                       'password'  => 'crypted_example'})
  end

  it { is_expected.to install_package 'libsasl2-modules' }
  it { is_expected.to install_package 'cyrus-sasl-plain' }
  it { is_expected.to render_file('/etc/postfix/sasl_passwd').with_content('[smtp.example.com] example:crypted_example')}

  let(:executor) { subject.bash('sasl_rehash') }
  let(:sasl_file) { subject.template('/etc/postfix/sasl_passwd') }

  it 'should run rehash' do
    expect(sasl_file).to notify('bash[sasl_rehash]').to(:run)
  end

  it 'should restart postfix' do
    expect(executor).to notify('service[postfix]').to(:restart).delayed
  end

end
