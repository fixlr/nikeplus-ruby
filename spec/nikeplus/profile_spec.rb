require File.dirname(__FILE__) + '/../spec_helper'

describe "NikePlus::Profile" do
  before(:all) do
    profile = REXML::Document.new(File.read(File.dirname(__FILE__) + "/../xml/login_successful.xml"))
    @profile = NikePlus::Profile.new(profile.root.elements['profile'])
  end
  
  it "should set the id" do
    @profile.id.should == "123456"
  end
  
  it "should set the first name" do
    @profile.firstName.should == "John"
  end
end