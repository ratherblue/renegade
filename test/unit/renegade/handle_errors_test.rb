require 'renegade/handle_errors'
require 'stringio'

describe Renegade::HandleErrors do
  subject { Renegade::HandleErrors }

  before do
    $stdout = StringIO.new
  end

  after(:all) do
    $stdout = STDOUT
  end

  it 'should not print warnings' do
    subject.handle_warnings([])
    $stdout.string.must_equal('')
  end

  it 'should print warnings' do
    subject.handle_warnings(['Warning 1', 'Warning 2'])
    $stdout.string.must_equal("
Warnings:
- Warning 1
- Warning 2

")
  end
end
