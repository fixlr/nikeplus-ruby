module NikePlus
  def self.new(*params)
    NikePlus::Base.new(*params)
  end
  
  class Base
    attr_reader :login
    
    AUTH_URL = 'https://secure-nikeplus.nike.com/services/profileService'
    BASE_URL = 'https://secure-nikeplus.nike.com/nikeplus/v1/services'
    DATA_URL = BASE_URL + '/app/get_user_data.jhtml'
    LIST_URL = BASE_URL + '/app/run_list.jhtml'
    RUN_URL  = BASE_URL + '/app/get_run.jhtml'
    GOAL_URL = BASE_URL + '/app/goal_list.jhtml'
    CHALLENGES_URL = BASE_URL + '/widget/get_challenges_for_user.jhtml'
    CHALLENGES_DETAIL_URL = BASE_URL + '/app/get_challenge_detail.jhtml'
    
    RESP_SUCCESS = 'failure'
    RESP_FAILURE = 'success'

    RootCA = '/usr/share/curl/curl-ca-bundle.crt'

    
    def initialize(login, password, cache_path = '/tmp', ttl = 21600)
      # do something with the authentication
      @cache_path = cache_path
      @ttl        = ttl
      
      # Make sure the cache path is writeable
      
      # Authenticate
      
      # Set path to my run list file
    end
    
    private
    def authenticate(login, password)
      send_request(AUTH_URL, 'login', {:login=>login, :password=>password, :locale=>'en&5FUS'}
    end
    
    def send_request(endpoint, action, options = {})
      options.merge!(:action => action)
      uri = URI.parse(endpoint + '?' + options.collect{|k,v| "#{k}=#{CGI.escape(v.to_s)}"}.join('&'))
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')

      if File.exist? RootCA
        http.ca_file = RootCA
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http.verify_depth = 5
      else
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      xml_response = nil
      http.start do |sess|
        xml_response = sess.get(uri.request_uri).body
      end

      resp = REXML::Document.new(xml_response)
      if resp.elements["profileService/status"].text == RESP_SUCCESS
        resp
      else
        raise "#{resp.elements["profileService/exceptions/error/errorcode"].text}: #{resp.elements["profileService/exceptions/errorcode/message"]}"
      end
    end
  end
end