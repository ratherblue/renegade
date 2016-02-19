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

  def fail_all_msg
    '  × Includes a valid BugId, Story or Epic number'.red + "\n" +
      '  × Commit message length'.red + "\n" +
      '  × Only ASCII characters'.red + "\n"
  end

  def success_msg
    '  √ Includes a valid BugId, Story or Epic number'.green + "\n" +
      '  √ Commit message length'.green + "\n" +
      '  √ Only ASCII characters'.green + "\n"
  end

  def fail_length_msg
    '  √ Includes a valid BugId, Story or Epic number'.green + "\n" +
      '  × Commit message length'.red + "\n" +
      '  √ Only ASCII characters'.green + "\n"
  end

  def fail_non_ascii_msg
    '  √ Includes a valid BugId, Story or Epic number'.green + "\n" +
      '  √ Commit message length'.green + "\n" +
      '  × Only ASCII characters'.red + "\n"
  end

  it 'should do nothing if not a message' do
    subject.new(['./test/fixtures/commit_messages/just_right.txt',
                 'something else']).run
    $stdout.string.must_equal('')
  end

  it 'should be too long' do
    subject.new(['./test/fixtures/commit_messages/too_long.txt',
                 'message']).run

    $stdout.string.must_equal("\nRunning prepare-commit-msg hooks…\n" +
      fail_length_msg + "\n"\
      "Errors:\n"\
      '- Commit messages should be between 7 and 50 characters.' + "\n\n")
  end

  it 'should be too short' do
    subject.new(['./test/fixtures/commit_messages/too_short.txt',
                 'message']).run

    $stdout.string.must_equal("\nRunning prepare-commit-msg hooks…\n" +
      fail_length_msg + "\n"\
      "Errors:\n"\
      '- Commit messages should be between 7 and 50 characters.' + "\n\n")
  end

  it 'should have non-ascii' do
    subject.new(['./test/fixtures/commit_messages/has_non_ascii.txt',
                 'message']).run

    $stdout.string.must_equal("\nRunning prepare-commit-msg hooks…\n" +
      fail_non_ascii_msg + "\n"\
      "Errors:\n"\
      '- Commit messages may not contain non-ASCII characters' + "\n\n")
  end

  it 'should fail everything' do
    subject.new(['./test/fixtures/commit_messages/fail_everything.txt',
                 'message']).run

    $stdout.string.must_equal("\nRunning prepare-commit-msg hooks…\n" +
      fail_all_msg + "\n"\
      "Errors:\n"\
      "- Commit messages should be between 7 and 50 characters.\n"\
      "- You must include a valid BugId, Story or Epic number.\n"\
      "  Examples:\n"\
      "  - BugId: 12345 | Helpful comment describing bug fix\n"\
      "  - Story: B-12345 | Helpful comment describing story\n"\
      "  - Epic: E-12345 | Epic comment\n"\
      '- Commit messages may not contain non-ASCII characters' + "\n\n")
  end

  it 'should be just right' do
    subject.new(['./test/fixtures/commit_messages/just_right.txt',
                 'message']).run

    $stdout.string.must_equal("\nRunning prepare-commit-msg hooks…\n" +
      success_msg)
  end
end
