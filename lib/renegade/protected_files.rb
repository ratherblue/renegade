require 'renegade/status'

module Renegade
  # Check protected files
  class ProtectedFiles
    attr_reader :warnings, :protected_files

    def initialize
      # Instance variables
      @warnings = []
      @protected_files = ['app.config', 'web.config']
    end

    def run(files)
      files.each do |file|
        if @protected_files.include?(File.basename(file).downcase)
          @warnings.push 'Warning! You are making changes to: ' + file.highlight
        end
      end
    end
  end
end
