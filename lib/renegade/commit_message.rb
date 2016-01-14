# require_relative 'status'
#
# module Renegade
#   ##
#   # Ensure commit messages meet certain requirements
#   class CommitMessage
#     def self.message_length(message)
#       min_length = 10
#       max_length = 50
#
#       puts 'Renegade::CommitMessage.message_length'
#
#       if message.length > min_length && message.length <= max_length
#         Renegade::Status.new.add_error('Commit messages should be between \
#           #{min_length} and #{max_length}')
#         false
#       else
#         true
#       end
#     end
#   end
# end
