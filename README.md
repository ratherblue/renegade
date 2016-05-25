# Renegade

[![Build Status](https://img.shields.io/travis/ratherblue/renegade.svg?style=flat-square)](https://travis-ci.org/ratherblue/renegade)
[![Coverage Status](https://img.shields.io/coveralls/ratherblue/renegade/master.svg?style=flat-square)](https://coveralls.io/r/ratherblue/renegade?branch=master)


Add this line to your application's Gemfile:

```ruby
gem 'renegade'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install renegade

## Usage

### Prepare Commit Message
In your Git project, open `.git/hooks/` and create a file called `prepare-commit-msg` (no extension). Copy and paste the following code:

```rb
#!/usr/bin/env ruby

require 'renegade/prepare_commit_msg'

Renegade::PrepareCommitMsg.new(ARGV).run or exit 1
```

### Pre-commit
In your Git project, open `.git/hooks/` and create a file called `pre-commit` (no extension). Copy and paste the following code:

```rb
#!/usr/bin/env ruby

require 'renegade/pre_commit'

files = `git diff --cached --name-only --diff-filter=ACM`
branch_name = `git name-rev --name-only HEAD`
markers = `git diff-index --check --cached HEAD --`

Renegade::PreCommit.new.run(files, branch_name, markers)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ratherblue/renegade.
