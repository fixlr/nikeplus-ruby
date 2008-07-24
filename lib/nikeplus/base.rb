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
    
    def initialize(login, password)
      # Authenticate
      @session = NikePlus::Session.new
      @session.authenticate(login, password)
      @runs = nil
    end
    
    def whoami
      @session.profile.login
    end
    
    def runs
      @runs ||= fetch_runs_list
    end
    
    private
    def fetch_runs_list
      list = []
      response = @session.send_request(RUNS_LIST_URL)
      response.fetch('runList').each_element_with_text do |run_xml|
        list << NikePlus::Run.new(run_xml)
      end
      list
    end
  end
end