require 'renegade/handle_errors'
require 'renegade/status'

# Array to store errors
@errors = []

module Renegade
  # Run linters
  class PrepareCommitMessage
    def initialize
      Renegade::Status.hook_start('prepare-commit-msg')
    end

    def run
      message_type = ARGV[1]

      # Avoid checking merges
      if message_type == 'message'
        message_file = ARGV[0]
        message = File.read(message_file)
        Renegade::CommitMessage.run(message)
      end

      Renegade::HandleErrors.handle_errors(@errors)
    end
  end
end
