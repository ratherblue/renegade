require 'renegade/status'

##
# Renegade module to run commit hooks
module Renegade
  def self.status
    @status ||= Renegade::Status.new
  end
end
