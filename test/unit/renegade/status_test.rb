require 'renegade/status'
require 'stringio'

describe Renegade::Status do
  subject { Renegade::Status }

  it 'shows error' do
    $stdout = StringIO.new
    subject.report('Some Label', true)
    $stdout.string.must_equal('  √ Some Label'.green)
  end
end
