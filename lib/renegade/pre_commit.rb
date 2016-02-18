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
      # @scss_lint = Renegade::Linters.new('SCSS Lint', '.scss', 'scss-lint')
      # @eslint = Renegade::Linters.new('ESLint', '.js', 'eslint')
      @branch_name = Renegade::BranchName.new('Branch Name')
      @conflict_markers = Renegade::ConflictMarkers.new('Conflict Markers')
      # @protected_files = Renegade::ProtectedFiles.new('Protected Files')

      run
    end

    def run
      # @scss_lint.run
      # @eslint.run
      @branch_name.run
      @conflict_markers.run
      # @protected_files.run

      Renegade::HandleErrors.handle_warnings(@branch_name.warnings)
      Renegade::HandleErrors.handle_errors(@conflict_markers.errors)

      # Renegade::HandleErrors.handle_errors(
      #   @scss_lint.errors + @eslint.errors +
      #   @branch_name.errors + @protected_files.errors)
    end
  end
end
