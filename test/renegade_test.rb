require 'test_helper'

# Renegade tests
class RenegadeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Renegade::VERSION
  end
end
