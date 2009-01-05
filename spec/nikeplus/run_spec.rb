require File.dirname(__FILE__) + '/../spec_helper'

describe "NikePlus::Run" do
  
  before(:all) do
    runs = REXML::Document.new(File.read(File.dirname(__FILE__) + "/../xml/runs_list.xml"))
    @run = NikePlus::Run.new(runs.root.elements['runList'].elements[1])
  end
  
  it "should set workoutType" do
    @run.workoutType.should == "standard"
  end
  
  it "should set id" do
    @run.id.should == '1'
  end

  it "should set startTime" do
    @run.startTime.should == '2008-05-17T16:27:33-04:00'
  end
  
  it "should set distance" do
    @run.distance.should == 4.1564
  end
  
  it "should set duration" do
    @run.duration.should == 2558375
  end
  
  it "should set syncTime" do
    @run.syncTime.should == '2008-05-17T21:12:13+00:00'
  end
  
  it "should set calories" do
    @run.calories.should == '409'
  end
  
  it "should set name" do
    @run.name.should == ''
  end
  
  it "should set description" do
    @run.description.should == ''
  end
  
  it "should return minutes" do
    @run.minutes.should == 42
  end
  
  it "should return seconds" do
    @run.seconds.should == 38
  end
  
  it "should return miles" do
    @run.miles.should == "2.58"
  end
end