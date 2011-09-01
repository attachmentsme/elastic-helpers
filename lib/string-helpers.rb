module ElasticHelpers
  class StringHelpers
    LUCENE_SPECIAL_CHARACTERS_REGEX = "[\\\\!\\-=+(){}[\\]\"^~*?:]"
    
    def self.configure(opts)
      opts = {
        :allow_quoted_strings => false
      }.update(opts)
    end
    
    def self.escape_for_lucene_search(search_string)
      search_string.gsub(/(#{LUCENE_SPECIAL_CHARACTERS_REGEX})/, '\\\\\1')
    end
  end
end

class String
  def escape_for_lucene_search
    ElasticHelpers::StringHelpers.escape_for_lucene_search(self)
  end
end