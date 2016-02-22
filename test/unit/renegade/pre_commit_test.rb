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

  it 'should run successfully' do
    pre_commit = subject.new
    pre_commit.run([], 'story-1234', '')
    $stdout.string.must_equal("\nRunning pre-commit hooks…\n" +
    '  √ SCSS Lint (0 files)'.green + "\n" +
    '  √ ESLint (0 files)'.green + "\n" +
    '  √ Branch Name'.green + "\n" +
    '  √ No merge artifacts'.green + "\n")
  end
  # 
  # it 'should fail eslint' do
  #   pre_commit = subject.new
  #   pre_commit.run(['./test/files/js/index.js',
  #                   './test/files/js/main.js'], 'story-1234', '')
  #
  #   $stdout.string.must_equal("\nRunning pre-commit hooks…\n" +
  #   '  √ SCSS Lint (0 files)'.green + "\n" +
  #   '  √ ESLint (0 files)'.green + "\n" +
  #   '  √ Branch Name'.green + "\n" +
  #   '  √ No merge artifacts'.green + "\n")
  # end
end
