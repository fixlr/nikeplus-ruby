require File.dirname(__FILE__) + '/../spec_helper'

describe "NikePlus::Session" do

  it "should call authenticate on initialization" do
    NikePlus::Session.any_instance.expects(:authenticate).with('john@example.com', 'secret').once.returns(true)
    
    session = NikePlus::Session.new('john@example.com', 'secret')
  end
  
  it "should fetch runs from API" do
    NikePlus::Session.any_instance.expects(:authenticate).with('john@example.com', 'secret').once.returns(true)
    
    raw_response = mock("RawResponse")
    raw_response.expects(:body).returns(File.read(File.dirname(__FILE__) + "/../xml/runs_list.xml"))
    
    NikePlus::Session.any_instance.expects(:send_request).returns(NikePlus::HttpResponse.new(raw_response))
    NikePlus::Run.expects(:new).times(10)
    
    session = NikePlus::Session.new('john@example.com', 'secret')
    session.runs
  end
end