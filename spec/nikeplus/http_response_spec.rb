require File.dirname(__FILE__) + '/../spec_helper'

describe "NikePlus::HttpResponse" do

  it "should raise an error if the response status cannot be retrieved" do
    r = create_response('bad_response.xml')
    lambda {
      r.success?
    }.should raise_error
  end
  
  it "should recognize failure response status" do
    r = create_response('loginFailed.xml')
    r.success?.should be_false
  end

  it "should recognize the error code after a failure" do
    r = create_response('loginFailed.xml')
    r.error_code.should == 'invalidPassword'
  end
  
  it "should recognize the error message after a failure" do
    r = create_response('loginFailed.xml')
    r.error_message.should == 'The password is incorrect'
  end
  
  
  it "should recognize successful response status" do
    r = create_response('login_successful.xml')
    r.success?.should be_true
  end
  
  it "should be able to fetch an element from the response" do
    r = create_response('login_successful.xml')
    r.fetch('profile/id').text.should == '123456'
  end
  
  it "should raise an error if the fetched element does not exist" do
    r = create_response('login_successful.xml')
    lambda {
      r.fetch('profile/bacon').text
    }.should raise_error
  end
  
  private
  def create_response(xml_file)
    raw_response = mock("RawResponse")
    raw_response.expects(:fetch).with('set-cookie').returns("COOKIE")
    raw_response.expects(:body).returns(File.read(File.dirname(__FILE__) + "/../xml/#{xml_file}"))
    
    NikePlus::HttpResponse.new(raw_response)
  end
end