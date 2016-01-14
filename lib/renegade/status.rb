class String
  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end
end

# Define string colors
module Renegade
  ##
  # Report statuses
  class Status
    # Report labels
    def self.report(label, passed)
      if passed
        puts "  √ #{label}".green
      else
        puts "  × #{label}".red
      end
    end

    def self.hook_start(hook)
      puts "\nRunning #{hook} hooks…"
    end
  end
end
