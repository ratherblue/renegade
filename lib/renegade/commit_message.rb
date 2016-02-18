require 'renegade/status'

module Renegade
  # Check commit messages meet certain criteria
  class CommitMessage
    attr_reader :errors, :warnings

    COMMIT_FORMAT = /^(?:(?:BugId: |Story: B+-|Epic: E-0)[1-9]\d* \| )(.*)/

    def initialize(label)
      # Instance variables
      @label = label
      @warnings = []
      @errors = []

      @min_length = 7
      @max_length = 50
    end

    def run(message)
      check_commit_message_format(message)
      check_commit_message_non_ascii(message)
    end

    # Check message length
    def check_commit_message_length(message)
      check_label = 'Commit message length'

      if message.length >= @min_length && message.length <= @max_length
        Status.report(check_label, true)
      else
        @errors.push "Commit messages should be between #{@min_length} "\
          "and #{@max_length} characters."
        Status.report(check_label, false)
      end
    end

    # Check commit message contains no non-ASCII characters
    def check_commit_message_non_ascii(message)
      check_label = 'Only ASCII characters'

      if message.ascii_only?
        Status.report(check_label, true)
      else
        Status.report(check_label, false)
        @errors.push 'Commit messages may not contain non-ASCII characters'
      end
    end

    def check_commit_message_format_error
      'You must include a valid BugId, Story or Epic number.' + "\n"\
      '  Examples:' + "\n"\
      '  - BugId: 12345 | Helpful comment describing bug fix' + "\n"\
      '  - Story: B-12345 | Helpful comment describing story' + "\n"\
      '  - Epic: E-12345 | Epic comment'
    end

    # Check commit message contains no non-ASCII characters
    def check_commit_message_format(message)
      check_label = 'Includes a valid BugId, Story or Epic number'

      matches = COMMIT_FORMAT.match(message)

      if matches
        Status.report(check_label, true)
        check_commit_message_length(matches[1])
      else
        Status.report(check_label, false)
        check_commit_message_length(message)
        @errors.push check_commit_message_format_error
      end
    end
  end
end
