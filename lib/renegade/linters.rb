require 'open3'
require 'renegade/status'

module Renegade
  # Run linters
  class Linters
    attr_reader :errors

    def initialize(label, extension, exec_command)
      # Instance variables
      @label = label
      @extension = extension
      @exec_command = exec_command
      @errors = []
    end

    def run(files)
      files = filter_files(files)
      append_file_count(files)

      # Only run check if there are relevant files being committed
      if files.size == 0
        Status.report(@label, true)
      else
        Status.report(@label, exec(files))
      end
    end

    # Add the file count to the end of the label
    def append_file_count(files)
      file_size = files.size

      if file_size == 0 || file_size > 1
        @label = "#{@label} (#{file_size} files)"
      else
        @label = "#{@label} (1 file)"
      end
    end

    def exec(files)
      # http://stackoverflow.com/questions/690151/getting-output-of-system-calls-in-ruby
      _stdin, stdout, stderr,
        wait_thread = Open3.popen3(@exec_command, files.join(' '))

      @errors.push(stdout.read) if wait_thread.value.exitstatus == 1

      stdout.gets(nil)
      stdout.close
      stderr.gets(nil)
      stderr.close

      wait_thread.value.exitstatus == 0
    end

    def filter_files(file_list)
      filtered_files = []

      file_list.each do |file|
        filtered_files.push(file) if File.extname(file) == @extension
      end

      filtered_files
    end
  end
end
