module Renegade
  class Branch_Names

    def self.check_branch_name(branch_name)
      if Renegade::Configuration.STORY_BRANCH.match(branch_name)
        # placeholder
        return true
      elsif Renegade::Configuration.BUG_BRANCH.match(branch_name)
        # placeholder
        return true
      else
        return false
      end
    end
  end
end
