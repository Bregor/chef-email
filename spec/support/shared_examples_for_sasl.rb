require_relative '../spec_helper'

RSpec.shared_examples 'sasl tuner' do
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
