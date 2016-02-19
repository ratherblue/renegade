require 'renegade/handle_errors'
require 'renegade/status'
require 'renegade/commit_message'

module Renegade
  # Run prepare commit message hooks
  class PrepareCommitMsg
    def initialize(args)
      @message = args[1]
      @message_file = args[0]

      # Avoid checking merges
      Renegade::Status.hook_start('prepare-commit-msg') if @message == 'message'
    end

    def run
      if @message == 'message' # Avoid checking merges
        commit_message = Renegade::CommitMessage.new
        commit_message.run(File.read(@message_file))

        Renegade::HandleErrors.handle_errors(commit_message.errors)
      end
    end
  end
end
