require 'renegade/status'

module Renegade
  ##
  # Prevent merge artifacts from getting committed
  class ConflictMarkers
    attr_reader :errors

    def initialize
      @label = 'No merge artifacts'
      @errors = []
    end

    def run(markers)
      # markers = `git diff-index --check --cached HEAD --`
      if markers == ''
        Status.report(@label, true)
      else
        Status.report(@label, false)
        @errors.push('Merge artifacts were found!' + "\n" + markers)
      end
    end
  end
end
