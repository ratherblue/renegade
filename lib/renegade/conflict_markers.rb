require 'open3'
require 'renegade/status'

module Renegade
  ##
  # Prevent merge artifacts from getting committed
  class ConflictMarkers
    attr_reader :errors, :warnings

    def initialize(label)
      # Instance variables
      @label = label
      @errors = []
    end

    def run
      markers = `git diff-index --check --cached HEAD --`

      Status.report(@label, check_markers(markers.chomp.strip))
    end

    def check_markers(markers)
      check_label = 'No merge artifacts'

      if markers == ''
        Status.report(check_label, true)
      else
        Status.report(check_label, false)
        @errors.push('Merge artifacts were found!' + "\n" + markers)
      end
    end
  end
end
