require 'renegade/handle_errors'
require 'renegade/status'
require 'renegade/commit_message'

module Renegade
  # Run prepare commit message hooks
  class PrepareCommitMsg
    def initialize(args)
      if args[1] == 'message' # Avoid checking merges
        Renegade::Status.hook_start('prepare-commit-msg')
        run(args[0])
      end
    end

    def run(message_file)
      commit_message = Renegade::CommitMessage.new
      commit_message.run(File.read(message_file))

      Renegade::HandleErrors.handle_errors(commit_message.errors)
    end
  end
end
