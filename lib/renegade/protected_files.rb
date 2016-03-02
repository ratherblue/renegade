require 'renegade/status'

module Renegade
  # Run linters
  class ProtectedFiles
    attr_reader :warnings, :errors, :protected_files

    def initialize
      # Instance variables
      @label = 'No accidental edit of protected files'
      @errors = []
      @warnings = []
      @protected_files = ['app.config', 'web.config']
    end

    def run(files)
      file_list = []
      files.each do |file|
        if @protected_files.include?(File.basename(file).downcase)
          file_list.push(File.expand_path(file))
          @warnings.push("Warning! You are making changes to: #{file}")
        end
      end

      report(file_list)
    end

    def report(file_list)
      Status.report(@label, !@warnings.empty?)

      unless @warnings.empty?
        @errors.push('You are trying to commit changes to the following'\
        'protected files:'\
        "\n#{file_list.join("\n")}")
        @errors.push(override_instructions)
      end
    end

    def check_commit_message(message)
      @protected_files.each do |file|
        true if message.include?(file)
      end

      false
    end

    def override_instructions
      'If you want to commit these changes, please add '\
      '"editing <file name>.config" to your commit message'\
      'If this was uninintentional: '\
      'Please unstage the files using `git reset HEAD <file name>`'
    end
  end
end
