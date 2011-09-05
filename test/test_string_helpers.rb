require 'helper'
require 'elastic-helpers'

class TestStringHelpers < Test::Unit::TestCase
  should "escape all lucene special characters by default" do
    assert_equal "\\+\\-\\!\\(\\)\\{\\}\\[\\]\\^\\\"\\~\\*\\?\\:\\\\", "+-!(){}[]^\"~*?:\\".escape_for_lucene_search #=+-!()
  end
end
