module NikePlus
  class Session
    attr_reader :profile

    # TODO:  Need a better way to handle the https for authentication
    RootCA = '/usr/share/curl/curl-ca-bundle.crt'
    AUTH_URL = 'https://secure-nikeplus.nike.com/services/profileService'

    def initialize
      @cookie = nil
      @profile = nil
    end
    
    def authenticate(login, password)
      response = send_request(AUTH_URL, 'login', {:login=>login, :password=>password, :locale=>'en&5FUS'})
      @cookie  = response.set_cookie
      @profile = NikePlus::Profile.new(response.body.root.elements["profile"])
    end
    
    def send_request(endpoint, action, options = {})
      uri  = parse(endpoint, options.merge(:action => action))
      resp = http(uri).start do |sess|
        NikePlus::HttpResponse.new(sess.get(uri.request_uri))
      end
    
      if resp.success?
        resp
      else
        raise "#{resp.error_code}: #{resp.error_message}"
      end
    end
    
    private
    def parse(endpoint, options)
      URI.parse("#{endpoint}?#{options.collect{|k,v| "#{k}=#{CGI.escape(v.to_s)}"}.join('&')}")
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
  end
end