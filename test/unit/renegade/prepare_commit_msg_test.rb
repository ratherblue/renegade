require 'renegade/prepare_commit_msg'
require 'stringio'

describe Renegade::PrepareCommitMsg do
  subject { Renegade::PrepareCommitMsg }

  before do
    $stdout = StringIO.new
  end

  after(:all) do
    $stdout = STDOUT
  end

  it 'should do nothing if not a message' do
    subject.new(['./test/fixtures/commit_messages/good/bug.txt',
                 'something else'])
    $stdout.string.must_equal('')
  end

  it 'should have a bug id' do
    subject.new(['./test/fixtures/commit_messages/good/bug.txt',
                 'message'])
    # puts $stdout.string

    $stdout.string.must_equal("\nRunning prepare-commit-msg hooks…\n")

    # 'test'.must_equal('test')
  end
end
