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

    expected_output = <<-EOF

Running pre-commit hooks…
#{'SCSS Lint (0 files)'.success}
#{'ESLint (0 files)'.success}
#{'Branch Name'.success}
#{'No merge artifacts'.success}
EOF

    $stdout.string.must_equal(expected_output)
  end

  it 'should pass eslint' do
    pre_commit = subject.new

    pre_commit.run(['./test/fixtures/js/index.js',
                    './test/fixtures/js/main.js'], 'story-1234', '')

    expected_output = <<-EOF

Running pre-commit hooks…
#{'SCSS Lint (0 files)'.success}
#{'ESLint (2 files)'.success}
#{'Branch Name'.success}
#{'No merge artifacts'.success}
EOF

    $stdout.string.must_equal(expected_output)
  end

  it 'should fail eslint' do
    pre_commit = subject.new

    file = File.expand_path('./test/fixtures/js/error.js')
    pre_commit.run([file], 'story-1234', '')

    # TODO: find a better way to write this
    $stdout.string.must_equal("\nRunning pre-commit hooks…\n" +
    'SCSS Lint (0 files)'.success + "\n" +
    'ESLint (1 file)'.error + "\n" +
    'Branch Name'.success + "\n" +
    'No merge artifacts'.success + "\n\n"\
    'Errors:' + "\n"\
    '- ' + "\n"\
    "#{file}\n"\
    '  1:14  error  Missing semicolon  semi' + "\n\n"\
    '✖ 1 problem (1 error, 0 warnings)' + "\n\n\n")
  end
end
