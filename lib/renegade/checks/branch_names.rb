module Renegade
  ##
  # Validate class names
  class BranchNames
    REGEX_STORY_BRANCH = /^(?:story)-(\d{4,6})?-?(.*)?$/
    REGEX_BUG_BRANCH = /^(?:bug)-(\d{4,6})?-?(.*)?$/

    def self.check_branch_name(branch_name)
      if REGEX_STORY_BRANCH.match(branch_name)
        # placeholder
        return true
      elsif REGEX_BUG_BRANCH.match(branch_name)
        # placeholder
        return true
      else
        return false
      end
    end
  end
end
