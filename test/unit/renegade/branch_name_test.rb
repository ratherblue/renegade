require 'renegade/branch_name'

describe Renegade::BranchName do
  subject { Renegade::BranchName }

  it 'should not be a valid branch name' do
    branch_check = subject.new
    branch_check.check_branch_name('zzzzzz').must_equal(false)
    branch_check.check_branch_name('bug').must_equal(false)
    branch_check.check_branch_name('bug-').must_equal(false)
    branch_check.check_branch_name('story').must_equal(false)
    branch_check.check_branch_name('story-').must_equal(false)
  end

  it 'should be a valid branch name' do
    branch_check = subject.new
    branch_check.check_branch_name('master').must_equal(true)
    branch_check.check_branch_name('bug-1234').must_equal(true)
    branch_check.check_branch_name('bug-1234-description').must_equal(true)
    branch_check.check_branch_name('bug-1234 description').must_equal(true)
    branch_check.check_branch_name('story-1234').must_equal(true)
    branch_check.check_branch_name('story-1234-description').must_equal(true)
    branch_check.check_branch_name('story-1234 description').must_equal(true)
  end

  it 'should populate warnings' do
    branch_check = subject.new
    branch_check.check_branch_name('bug').must_equal(false)
    branch_check.warnings.size.must_equal(2)
    branch_check.warnings[0].must_equal('Branches must start with bug-##### '\
      'or story-#####.')
    branch_check.warnings[1].must_equal('You may continue to develop in this '\
      'branch, but you will not be allowed to merge unless you rename it.')
  end
end
