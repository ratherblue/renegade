require 'renegade/commit_message'
require 'stringio'

describe Renegade::CommitMessage do
  subject { Renegade::CommitMessage }

  before do
    $stdout = StringIO.new
  end

  after(:all) do
    $stdout = STDOUT
  end

  it 'should be between a certain length' do
    commit_message = subject.new('Commit Message')
    commit_message.run('This is a test commit message')

    $stdout.string.must_equal('  √ Commit message length'.green + "\n" +
  '  √ Only ASCII characters'.green + "\n")

    commit_message.errors.size.must_equal(0)
  end

  it 'should not be below a certain length' do
    commit_message = subject.new('Commit Message')
    commit_message.run('1234')

    $stdout.string.must_equal('  × Commit message length'.red + "\n" +
  '  √ Only ASCII characters'.green + "\n")

    commit_message.errors.size.must_equal(1)
    commit_message.errors[0].must_equal('Commit messages should be between '\
    '7 and 50 characters.')
  end

  it 'should not be above a certain length' do
    commit_message = subject.new('Commit Message')
    commit_message.run('really, really, really, really, really, really, long '\
    'commit message')

    $stdout.string.must_equal('  × Commit message length'.red + "\n" +
  '  √ Only ASCII characters'.green + "\n")

    commit_message.errors.size.must_equal(1)
    commit_message.errors[0].must_equal('Commit messages should be between '\
    '7 and 50 characters.')
  end

  it 'should not have non-ascii characters' do
    commit_message = subject.new('Commit Message')
    commit_message.run('セーラームーン が 大好き！')

    $stdout.string.must_equal('  √ Commit message length'.green + "\n" +
  '  × Only ASCII characters'.red + "\n")

    commit_message.errors.size.must_equal(1)
    commit_message.errors[0].must_equal('Commit messages may not contain '\
    'non-ASCII characters')
  end
end
