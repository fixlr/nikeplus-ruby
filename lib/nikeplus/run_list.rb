module NikePlus
  class RunList
    RUNS_URL = "https://secure-nikeplus.nike.com/nikeplus/v1/services/app/run_list.jhtml"
    
    def initialize(session)
      @session = session
      @runs = []

      response = @session.send_request(RUNS_URL)
      response.fetch('runList').each_element_with_text do |run_xml|
        @runs << Run.new(run_xml)
      end
    end
  end
end