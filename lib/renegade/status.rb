# Add color options
class String
  def success
    "\e[32m  √ #{self}\e[0m"
  end

  def warning
    "\e[33m  × #{self}\e[0m"
  end

  def error
    "\e[31m  × #{self}\e[0m"
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
        puts label.success
      elsif warning
        puts label.warning
      else
        puts label.error
      end
    end

    def self.hook_start(hook)
      puts "\nRunning #{hook} hooks…"
    end
  end
end
