require File.dirname(__FILE__) + '/../spec_helper'

describe "NikePlus::Base" do
  it "should authenticate without uid" do
    mock_session = mock(NikePlus::Session)
    NikePlus::Session.should_receive(:new).and_return(mock_session)
    mock_session.should_receive(:authenticate).with('john@example.com', 'secret').once.and_return(true)
    
    nikeplus = NikePlus.new('john@example.com', 'secret')
  end
  
  it "should not authenticate with uid" do
    NikePlus::Session.should_not_receive(:new)
    
    nikeplus = NikePlus.new(nil, nil, 00000000)
  end
  
  it "should fetch runs from API" do
    mock_session = mock(NikePlus::Session)
    NikePlus::Session.should_receive(:new).and_return(mock_session)
    mock_session.should_receive(:authenticate).with('john@example.com', 'secret').once.and_return(true)

    raw_response = mock("RawResponse")
    raw_response.should_receive(:fetch).with('set-cookie').and_return("COOKIE")
    raw_response.should_receive(:body).and_return(File.read(File.dirname(__FILE__) + "/../xml/runs_list.xml"))
    
    mock_session.should_receive(:send_request).with(NikePlus::Base::RUNS_LIST_URL).and_return(NikePlus::HttpResponse.new(raw_response))
    
    nikeplus = NikePlus.new('john@example.com', 'secret')
    nikeplus.runs
  end
  
  it "should fetch runs from the xml feed" do
    mock_response = mock("response")
    Net::HTTP.should_receive(:start).and_return(mock_response)
    
    raw_response = mock("RawResponse")
    raw_response.should_receive(:body).and_return(File.read(File.dirname(__FILE__) + "/../xml/runs_list.xml"))
    
    mock_response.should_receive(:get).and_return(raw_response)

    nikeplus = NikePlus.new(nil, nil, 00000000)
    nikeplus.runs
  end
end