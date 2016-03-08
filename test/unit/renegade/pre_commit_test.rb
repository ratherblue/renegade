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

  it 'should skip successfully' do
    pre_commit = subject.new
    pre_commit.run('', 'story-1234', '')

    expected_output = <<-EOF

#{'Running pre-commit hooks…'.status}
EOF

    $stdout.string. must_equal(expected_output)
  end

  it 'should pass everything' do
    pre_commit = subject.new

    pre_commit.run("./test/fixtures/js/index.js\n"\
                    "./test/fixtures/js/main.js\n"\
                    "./test/fixtures/html/index.html\n"\
                    "./test/fixtures/scss/partials/_base.scss\n"\
                    "./test/fixtures/scss/styles.scss\n", 'story-1234', '')

    expected_output = <<-EOF

#{'Running pre-commit hooks…'.status}
#{'SCSS Lint (2 files)'.success}
#{'ESLint (2 files)'.success}
#{'Branch Name'.success}
#{'No merge artifacts'.success}
EOF

    $stdout.string.must_equal(expected_output)
  end

  it 'should fail eslint' do
    pre_commit = subject.new

    file = File.expand_path('./test/fixtures/js/error.js')
    pre_commit.run(file, 'story-1234', '')

    # TODO: find a better way to write this
    $stdout.string.must_equal("\n"\
    "\e[35mRunning pre-commit hooks…\e[0m\n" +
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

  it 'should fail scss-lint' do
    pre_commit = subject.new

    file = File.expand_path('./test/fixtures/scss/partials/_error.scss')
    pre_commit.run(file,
                   'story-1234', '')

    expected_output = <<-EOF

#{'Running pre-commit hooks…'.status}
#{'SCSS Lint (1 file)'.error}
#{'ESLint (0 files)'.success}
#{'Branch Name'.success}
#{'No merge artifacts'.success}

Errors:
- #{file}:2 [W] TrailingSemicolon: Declaration should be terminated by a semicolon
#{file}:2 [W] ImportantRule: !important should not be used


EOF

    $stdout.string.must_equal(expected_output)
  end

  it 'should fail merge artifacts' do
    pre_commit = subject.new

    pre_commit.run(
      File.expand_path('./test/fixtures/scss/partials/_base.scss'),
      'story-1234',
      "temp.txt:1: leftover conflict marker\n"\
      "temp.txt:3: leftover conflict marker\n"\
      "temp.txt:5: leftover conflict marker\n")

    expected_output = <<-EOF

#{'Running pre-commit hooks…'.status}
#{'SCSS Lint (1 file)'.success}
#{'ESLint (0 files)'.success}
#{'Branch Name'.success}
#{'No merge artifacts'.error}

Errors:
- Merge artifacts were found!
temp.txt:1: leftover conflict marker
temp.txt:3: leftover conflict marker
temp.txt:5: leftover conflict marker

EOF

    $stdout.string.must_equal(expected_output)
  end

  it 'should skip successfully' do
    pre_commit = subject.new
    pre_commit.run('', 'story-1234', '')

    expected_output = <<-EOF

#{'Running pre-commit hooks…'.status}
EOF

    $stdout.string.must_equal(expected_output)
  end

  it 'should warn protected files' do
    pre_commit = subject.new

    file1 = File.expand_path('./test/fixtures/web.config')
    file2 = File.expand_path('./test/fixtures/app.config')
    pre_commit.run(file1 + "\n" + file2, 'story-1234', '')

    expected_output = <<-EOF

#{'Running pre-commit hooks…'.status}
#{'SCSS Lint (0 files)'.success}
#{'ESLint (0 files)'.success}
#{'Branch Name'.success}
#{'No merge artifacts'.success}

Warnings:
- Warning! You are making changes to: #{file1.highlight}
- Warning! You are making changes to: #{file2.highlight}

EOF

    $stdout.string.must_equal(expected_output)
  end
end
