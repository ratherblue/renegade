require 'renegade/status'

module Renegade
  # Check commit messages meet certain criteria
  class CommitMessage
    attr_reader :errors, :warnings

    def initialize(label)
      # Instance variables
      @label = label
      @warnings = []
      @errors = []

      @min_length = 7
      @max_length = 50
    end

    def run(message)
      check_commit_message_length(message)
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
  end
end
