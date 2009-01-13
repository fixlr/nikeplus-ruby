module NikePlus
  class Feed
    XML_BASE_URL = 'http://nikeplus.nike.com/nikeplus/v1/services/widget/get_public_run_list.jsp?userID='
    
    def initialize(uid)
      @uid = uid
      @runs = nil
    end
    
    def runs
      @runs ||= fetch_runs_list
    end
    
    private
    def fetch_runs_list
      uri = URI.parse(XML_BASE_URL + @uid.to_s)
      http = Net::HTTP.start(uri.host)
      @doc = REXML::Document.new(http.get(uri.request_uri).body)
      
      list = []
      
      @doc.root.elements["runList"].each_element_with_text do |run_xml|
        list << NikePlus::Run.new(run_xml)
      end
      list
    end
  end
end