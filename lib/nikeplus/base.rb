module NikePlus
  def self.new(*params)
    NikePlus::Base.new(*params)
  end
  
  class Base
    attr_reader :login
    
    BASE_URL = 'https://secure-nikeplus.nike.com/nikeplus/v1/services'
    DATA_URL = BASE_URL + '/app/get_user_data.jhtml'
    RUNS_LIST_URL = BASE_URL + '/app/run_list.jhtml'
    RUN_URL  = BASE_URL + '/app/get_run.jhtml'
    GOAL_URL = BASE_URL + '/app/goal_list.jhtml'
    CHALLENGES_URL = BASE_URL + '/widget/get_challenges_for_user.jhtml'
    CHALLENGES_DETAIL_URL = BASE_URL + '/app/get_challenge_detail.jhtml'
    XML_BASE_URL = 'http://nikeplus.nike.com/nikeplus/v1/services/widget/get_public_run_list.jsp?userID='
    
    def initialize(login, password, uid=nil)
      @uid = uid
      # Authenticate
      unless @uid
        @session = NikePlus::Session.new
        @session.authenticate(login, password)
      end
      @runs = nil
    end
    
    def runs
      @runs ||= fetch_runs
    end
    
    private
    def fetch_runs
      @uid ? fetch_runs_from_xml : fetch_runs_list
    end
    
    def fetch_runs_list
      list = []
      response = @session.send_request(RUNS_LIST_URL)
      response.fetch('runList').each_element_with_text do |run_xml|
        list << NikePlus::Run.new(run_xml)
      end
      list
    end
    
    def fetch_runs_from_xml
      #TODO I think these feed functions should belong in their own class
      uri = URI.parse(XML_BASE_URL + @uid.to_s)
      http = Net::HTTP.start(uri.host)
      doc = REXML::Document.new(http.get(uri.request_uri).body)
      
      list = []
      
      doc.root.elements['runList'].each_element_with_text do |run|
        list << NikePlus::Run.new(run)
      end
      list
    end
  end
end