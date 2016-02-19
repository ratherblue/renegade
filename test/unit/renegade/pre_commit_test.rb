require 'renegade/pre_commit'
require 'stringio'

describe Renegade::PreCommit do
  subject { Renegade::PreCommit }

  before do
    $stdout = StringIO.new
  end

  after(:all) do
    $stdout = STDOUT
  end

  it 'should set up the runners' do
    subject.new

    $stdout.string.must_equal("\nRunning pre-commit hooks…\n")
  end
end
