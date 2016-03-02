require 'renegade/handle_errors'
require 'renegade/status'
require 'renegade/linters'
require 'renegade/branch_name'
require 'renegade/conflict_markers'
require 'renegade/protected_files'

module Renegade
  # Run linters
  class PreCommit
    def initialize
      Renegade::Status.hook_start('pre-commit')
      @scss_lint = Renegade::Linters.new('SCSS Lint', '.scss', 'scss-lint')
      @eslint = Renegade::Linters.new('ESLint', '.js', 'eslint')
      @branch_name = Renegade::BranchName.new
      @conflict_markers = Renegade::ConflictMarkers.new
      @protected_files = Renegade::ProtectedFiles.new
    end

    def run(files, branch_name, markers)
      unless files.empty?
        files = files.split("\n")
        @scss_lint.run(files)
        @eslint.run(files)
        @branch_name.run(branch_name)
        @conflict_markers.run(markers)
        @protected_files.run(files)
      end

      handle_errors
    end

    def handle_errors
      Renegade::HandleErrors.handle_warnings(@branch_name.warnings +
        @protected_files.warnings)
      Renegade::HandleErrors.handle_errors(@scss_lint.errors +
        @eslint.errors + @conflict_markers.errors + @protected_files.errors)
    end
  end
end
