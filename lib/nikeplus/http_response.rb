module NikePlus
  class HttpResponse
    attr_reader :set_cookie, :body

    RESP_SUCCESS = 'success'
    RESP_FAILURE = 'failure'
    
    def initialize(response)
      @set_cookie = response.fetch('set-cookie')
      @body = REXML::Document.new(response.body)
    end

    def error_code
      @body.root.elements["exceptions/error/errorcode"].text
    end
    
    def error_message
      @body.root.elements["exceptions/error/message"].text
    end
    
    def response_status
      @body.root.elements["status"].text
    end
    
    def success?
      response_status == RESP_SUCCESS
    end
  end
end