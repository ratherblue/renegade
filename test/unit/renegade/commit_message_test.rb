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

  def success_msg
    'Includes a valid BugId, Story or Epic number'.success + "\n" +
      'Commit message length'.success + "\n" +
      'Only ASCII characters'.success + "\n"
  end

  it 'should contain a bug id, story, or epic id' do
    commit_message = subject.new
    commit_message.run('BugId: 12345 | Example comment')

    $stdout.string.must_equal(success_msg)

    commit_message.errors.size.must_equal(0)
  end

  it 'should contain a story id' do
    commit_message = subject.new
    commit_message.run('Story: B-12345 | Example comment')

    $stdout.string.must_equal(success_msg)

    commit_message.errors.size.must_equal(0)
  end

  it 'should contain an epic id' do
    commit_message = subject.new
    commit_message.run('Epic: E-0345 | Example comment')

    $stdout.string.must_equal(success_msg)

    commit_message.errors.size.must_equal(0)
  end

  it 'should not be below a certain length' do
    commit_message = subject.new
    commit_message.run('Story: B-12345 | 123')

    $stdout.string.must_equal(
      'Includes a valid BugId, Story or Epic number'.success + "\n" +
      'Commit message length'.error + "\n" +
      'Only ASCII characters'.success + "\n")

    commit_message.errors.size.must_equal(1)
    commit_message.errors[0].must_equal('Commit messages should be between '\
    '7 and 50 characters.')
  end

  it 'should not be above a certain length' do
    commit_message = subject.new
    commit_message.run('BugId: 1234 | really, really, really, really, '\
    'really, really long commit message')

    $stdout.string.must_equal(
      'Includes a valid BugId, Story or Epic number'.success + "\n" +
      'Commit message length'.error + "\n" +
      'Only ASCII characters'.success + "\n")

    commit_message.errors.size.must_equal(1)
    commit_message.errors[0].must_equal('Commit messages should be between '\
    '7 and 50 characters.')
  end

  it 'should not have non-ascii characters' do
    commit_message = subject.new
    commit_message.run('Story: B-12345 | セーラームーン が 大好き！')

    $stdout.string.must_equal(
      'Includes a valid BugId, Story or Epic number'.success + "\n" +
      'Commit message length'.success + "\n" +
      'Only ASCII characters'.error + "\n")

    commit_message.errors.size.must_equal(1)
    commit_message.errors[0].must_equal('Commit messages may not contain '\
    'non-ASCII characters')
  end
end
