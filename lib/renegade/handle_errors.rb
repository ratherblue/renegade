module Renegade
  ##
  # Handle errors
  class HandleErrors
    # Handle errors if they exist
    def self.handle_errors(errors)
      if errors.size > 0
        print_errors(errors)
        exit 1
      else
        exit 0
      end
    end

    def self.handle_warnings(warnings)
      print_warnings(warnings) if warnings.size > 0
    end

    def self.print_errors(errors)
      puts "\nErrors:"

      errors.each do |error|
        puts "- #{error}"
      end

      puts "\n"
    end

    def self.print_warnings(warnings)
      puts "\nWarnings:"

      warnings.each do |warning|
        puts "- #{warning}"
      end

      puts "\n"
    end
  end
end
