module Renegade
  ##
  # Ensure commit messages meet certain requirements
  class CommitMessage
    def self.message_length(message)
      min_length = 10
      max_length = 50

      puts 'Renegade::CommitMessage.message_length'

      (message.length > min_length && message.length <= max_length)
    end
  end
end
