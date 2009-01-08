module NikePlus
  class RunFeed
    XML_BASE_URL = 'http://nikeplus.nike.com/nikeplus/v1/services/widget/get_public_run_list.jsp?userID='
    
    def initialize(uid)
      
      uri = URI.parse(XML_BASE_URL + uid.to_s)
      http = Net::HTTP.start(uri.host)
      @doc = REXML::Document.new(http.get(uri.request_uri).body)
    end
    
    def fetch(key)
      @doc.root.elements["#{key}"]
    end
  end
end