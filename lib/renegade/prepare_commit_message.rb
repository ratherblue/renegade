require 'renegade/handle_errors'
require 'renegade/status'
require 'renegade/commit_message'

# Array to store errors
@errors = []

module Renegade
  # Run linters
  class PrepareCommitMessage
    def initialize
      Renegade::Status.hook_start('prepare-commit-msg')

      run
    end

    def run
      message_type = ARGV[1]

      commit_message = Renegade::CommitMessage.new('Commit Message')

      # Avoid checking merges
      if message_type == 'message'
        message_file = ARGV[0]
        message = File.read(message_file)
        commit_message.run(message)
      end

      Renegade::HandleErrors.handle_errors(commit_message.errors)
    end
  end
end
