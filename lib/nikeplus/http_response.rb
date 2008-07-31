module NikePlus
  class HttpResponse
    attr_reader :cookie, :body

    RESP_SUCCESS = 'success'
    RESP_FAILURE = 'failure'
    
    def initialize(response)
      @cookie = response.fetch('set-cookie') rescue IndexError
      @body = REXML::Document.new(response.body)
    end

    def error_code
      fetch("exceptions/error/errorcode").text
    end
    
    def error_message
      fetch("exceptions/error/message").text
    end
    
    def response_status
      fetch("status").text
    end
    
    def success?
      response_status == RESP_SUCCESS
    end
    
    # Return the text from an XML node in the response
    def fetch(key)
      raise "Node #{key} was not found" if @body.root.elements["#{key}"].nil?
      @body.root.elements["#{key}"]
    end
  end
end