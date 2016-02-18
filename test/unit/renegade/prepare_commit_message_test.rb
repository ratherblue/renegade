require 'renegade/prepare_commit_message'

describe Renegade::PrepareCommitMessage do
  subject { Renegade::PrepareCommitMessage }

  before do
    $stdout = StringIO.new
  end

  after(:all) do
    $stdout = STDOUT
  end

  it 'should should check the commit message' do
  end
end
