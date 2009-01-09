require File.dirname(__FILE__) + '/../spec_helper'

describe "NikePlus::Session" do

  #TODO update session specs for new structure
  it "should authenticate on initialization" do
    pending
  end
  
  it "should fetch runs from API" do
    pending
  #   mock_session = mock(NikePlus::Session)
  #   NikePlus::Session.should_receive(:new).and_return(mock_session)
  #   mock_session.should_receive(:authenticate).with('john@example.com', 'secret').once.and_return(true)
  # 
  #   raw_response = mock("RawResponse")
  #   raw_response.should_receive(:fetch).with('set-cookie').and_return("COOKIE")
  #   raw_response.should_receive(:body).and_return(File.read(File.dirname(__FILE__) + "/../xml/runs_list.xml"))
  #   
  #   mock_session.should_receive(:send_request).with(NikePlus::Base::RUNS_LIST_URL).and_return(NikePlus::HttpResponse.new(raw_response))
  #   
  #   nikeplus = NikePlus.new('john@example.com', 'secret')
  #   nikeplus.runs
  end
end