require 'renegade/handle_errors'
require 'stringio'
require 'open3'

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

  it 'should print errors' do
    subject.print_errors(['Error 1', 'Error 2'])
    $stdout.string.must_equal("
Errors:
- Error 1
- Error 2

")
  end
end
