require 'helper'
require 'elastic-helpers'

class TestStringHelpers < Test::Unit::TestCase
  should "escape all lucene special characters by default" do
    assert_equal "\\+\\-\\!\\(\\)\\{\\}\\[\\]\\^\\\"\\~\\*\\?\\:\\\\", "+-!(){}[]^\"~*?:\\".escape_for_lucene_search #=+-!()
  end
  
  should "not escape surrounding quotes if quotes are whitelisted in configuration" do
    ElasticHelpers::StringHelpers.configure({})
    puts('"Foobar"'.escape_for_lucene_search)
    assert_equal '\"Foobar\"', '"Foobar"'.escape_for_lucene_search
  end
end
