require 'renegade/handle_errors'
require 'renegade/status'
require 'renegade/linters'
require 'renegade/branch_name'
require 'renegade/conflict_markers'

module Renegade
  # Run linters
  class PreCommit
    def initialize
      Renegade::Status.hook_start('pre-commit')
      @scss_lint = Renegade::Linters.new('SCSS Lint', '.scss', 'scss-lint')
      @eslint = Renegade::Linters.new('ESLint', '.js', 'eslint')
      @branch_name = Renegade::BranchName.new
      @conflict_markers = Renegade::ConflictMarkers.new
      # @protected_files = Renegade::ProtectedFiles.new('Protected Files')
    end

    def run(files, branch_name, markers)
      unless files.empty?
        @scss_lint.run(files)
        @eslint.run(files)
        @branch_name.run(branch_name)
        @conflict_markers.run(markers)
        # @protected_files.run

        Renegade::HandleErrors.handle_warnings(@branch_name.warnings)
        Renegade::HandleErrors.handle_errors(@scss_lint.errors +
          @eslint.errors + @conflict_markers.errors)
      end
    end
  end
end
