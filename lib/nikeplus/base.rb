module NikePlus
  def self.new(*params)
    NikePlus::Base.new(*params)
  end
  
  class Base
    attr_reader :login
    
    BASE_URL = 'https://secure-nikeplus.nike.com/nikeplus/v1/services'
    DATA_URL = BASE_URL + '/app/get_user_data.jhtml'
    LIST_URL = BASE_URL + '/app/run_list.jhtml'
    RUN_URL  = BASE_URL + '/app/get_run.jhtml'
    GOAL_URL = BASE_URL + '/app/goal_list.jhtml'
    CHALLENGES_URL = BASE_URL + '/widget/get_challenges_for_user.jhtml'
    CHALLENGES_DETAIL_URL = BASE_URL + '/app/get_challenge_detail.jhtml'
    
    def initialize(login, password)
      # Authenticate
      @session = NikePlus::Session.new
      @session.authenticate(login, password)
    end
    
    def whoami
      @session.profile.login
    end
    
    def runs
      @runs ||= RunList.new(@session)
    end
  end
end