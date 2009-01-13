require File.dirname(__FILE__) + '/../spec_helper'

describe "NikePlus::Feed" do
  
  it "should get runs from xml feed" do
    mock_response = mock("response")
    Net::HTTP.expects(:start).returns(mock_response)
    
    raw_response = mock("RawResponse")
    raw_response.expects(:body).returns(File.read(File.dirname(__FILE__) + "/../xml/runs_list.xml"))
    
    mock_response.expects(:get).returns(raw_response)
    
    NikePlus::Run.expects(:new).times(10)
    
    run_feed = NikePlus::Feed.new(060606)
    run_feed.runs
  end
end