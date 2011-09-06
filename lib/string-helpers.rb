module ElasticHelpers
  class StringHelpers
    
    @@allow_quoted_strings = false
    
    LUCENE_SPECIAL_CHARACTERS_REGEX = "[\\\\!\\-=+(){}\\[\\]\"^~*?:]"
    
    def self.configure(opts)
      opts = {
        :allow_quoted_strings => false
      }.update(opts)
      
      @@allow_quoted_strings = opts[:allow_quoted_strings]
    end
    
    def self.escape_for_lucene_search(search_string)
      escaped_search_string = search_string
      escaped_search_string = escaped_search_string.slice(1..escaped_search_string.length() - 2) if string_has_surrounding_quotes?(search_string)
      escaped_search_string.gsub!(/(#{LUCENE_SPECIAL_CHARACTERS_REGEX})/, '\\\\\1')
      escaped_search_string = "\"#{escaped_search_string}\"" if string_has_surrounding_quotes?(search_string)
      escaped_search_string
    end
    
    private
    
    def self.string_has_surrounding_quotes?(search_string)
      if @@allow_quoted_strings and search_string[0, 1] == '"' and search_string[-1, 1] == '"'
        return true
      end
      return false
    end
  end
end

class String
  def escape_for_lucene_search
    ElasticHelpers::StringHelpers.escape_for_lucene_search(self)
  end
end