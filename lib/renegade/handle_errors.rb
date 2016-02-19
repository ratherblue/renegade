module Renegade
  ##
  # Handle errors
  class HandleErrors
    # Handle errors if they exist
    def self.handle_errors(errors)
      if errors.empty?
        true
      else
        print_errors(errors)
        false
      end
    end

    def self.handle_warnings(warnings)
      print_warnings(warnings) unless warnings.empty?
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
