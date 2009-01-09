require File.dirname(__FILE__) + '/../spec_helper'

describe "NikePlus::RunFeed" do
  
  it "should get runs from xml feed" do
    mock_response = mock("response")
    Net::HTTP.should_receive(:start).and_return(mock_response)
    
    raw_response = mock("RawResponse")
    raw_response.should_receive(:body).and_return(File.read(File.dirname(__FILE__) + "/../xml/runs_list.xml"))
    
    mock_response.should_receive(:get).and_return(raw_response)
    
    NikePlus::Run.should_receive(:new).exactly(10).times
    
    run_feed = NikePlus::RunFeed.new(060606)
    run_feed.runs
  end
end