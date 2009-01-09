module NikePlus
  class Session
    attr_reader :profile

    # TODO:  Need a better way to handle the https for authentication than
    # this stupid hard coded path...
    RootCA = '/usr/share/curl/curl-ca-bundle.crt'
    AUTH_URL = 'https://secure-nikeplus.nike.com/services/profileService'

    def initialize(login, password)
      @cookie = nil
      @profile = nil
      @runs = nil
      @login = login
      @password = password
      
      authenticate(@login, @password)
    end
    
    def runs
      @runs ||= fetch_runs_list
    end
    
    def authenticate(login, password)
      response = send_request(AUTH_URL, {:action => 'login', :login=>login, :password=>password, :locale=>'en&5FUS'})
      @cookie  = response.cookie
      @profile = NikePlus::Profile.new(response.fetch("profile"))
    end
    
    def send_request(endpoint, options = {})
      uri  = URI.parse("#{endpoint}#{parse_opts(options)}")
      params = @cookie.nil? ? [uri.request_uri] : [uri.request_uri, {'Cookie' => @cookie}]
      resp = http(uri).start do |sess|
        NikePlus::HttpResponse.new(sess.get(*params))
      end
    
      if resp.success?
        resp
      else
        raise "#{resp.error_code}: #{resp.error_message}"
      end
    end
    
    private
    def parse_opts(options)
      options.length > 0 ? "?#{options.collect{|k,v| "#{k}=#{CGI.escape(v.to_s)}"}.join('&')}" : ""
    end

    def http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      if http.use_ssl = (uri.scheme == 'https')
        if File.exist? RootCA
          http.ca_file = RootCA
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER
          http.verify_depth = 5
        else
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
      end
      http
    end
  
    def fetch_runs_list
      list = []
      response = send_request(Base::RUNS_LIST_URL)
      
      response.fetch('runList').each_element_with_text do |run_xml|
        list << NikePlus::Run.new(run_xml)
      end
      list
    end
  end
end