require 'helper'
require 'elastic-helpers'

class TestStringHelpers < Test::Unit::TestCase
  should "escape all lucene special characters by default" do
    ElasticHelpers::StringHelpers.configure({})
    assert_equal "\\+\\-\\!\\(\\)\\{\\}\\[\\]\\^\\\"\\~\\*\\?\\:\\\\", "+-!(){}[]^\"~*?:\\".escape_for_lucene_search #=+-!()
  end
  
  should "not escape surrounding quotes if quotes are whitelisted in configuration" do
    ElasticHelpers::StringHelpers.configure({})
    assert_equal '\"Foobar\"', '"Foobar"'.escape_for_lucene_search
    ElasticHelpers::StringHelpers.configure({
      :allow_quoted_strings => true
    })
    assert_equal '"Foobar\\!"', '"Foobar!"'.escape_for_lucene_search
    assert_equal 'Foobar\\!\\"', 'Foobar!"'.escape_for_lucene_search
    assert_equal '\\"Foobar\\!', '"Foobar!'.escape_for_lucene_search
  end
  
  should "allow wild cards in search if option turned on" do
    ElasticHelpers::StringHelpers.configure({})
    assert_equal '\\"H\\*\\*\\*y\\!', '"H***y!'.escape_for_lucene_search
    ElasticHelpers::StringHelpers.configure({
      :allow_quoted_strings => true,
      :allow_wildcards => true
    })
    assert_equal '\\"H***y\\!', '"H***y!'.escape_for_lucene_search
  end
end
