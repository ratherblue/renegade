require 'renegade/status'

module Renegade
  ##
  # Verify branch name
  class BranchName
    attr_reader :errors, :warnings

    REGEX_STORY_BRANCH = /^(?:story)-(\d{4,6})-?(.*)?$/
    REGEX_BUG_BRANCH = /^(?:bug)-(\d{4,6})-?(.*)?$/

    def initialize
      # Instance variables
      @label = 'Branch Name'
      @warnings = []
      @errors = []
    end

    def run(branch_name)
      # branch_name = `git name-rev --name-only HEAD`

      Status.report(@label, check_branch_name(branch_name), true)
    end

    def check_branch_name(branch_name)
      if REGEX_STORY_BRANCH.match(branch_name) ||
         REGEX_BUG_BRANCH.match(branch_name) ||
         branch_name == 'master'
        # placeholder
        return true
      else
        @warnings.push('Branches must start with bug-##### or story-#####.')
        @warnings.push('You may continue to develop in this branch, but you'\
          ' will not be allowed to merge unless you rename it.')
        return false
      end
    end
  end
end
