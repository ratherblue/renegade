# Add color options
class String
  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end

  def yellow
    "\e[103m#{self}\e[0m"
  end
end

# Define string colors
module Renegade
  ##
  # Report statuses
  class Status
    # Report labels
    def self.report(label, passed, warning = nil)
      if passed
        puts "  √ #{label}".green
      else
        if warning
          puts "  × #{label}".yellow
        else
          puts "  × #{label}".red
        end
      end
    end

    def self.hook_start(hook)
      puts "\nRunning #{hook} hooks…"
    end
  end
end
