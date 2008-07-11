require 'net/http'
require 'net/https'
require 'uri'
require 'rexml'

%w{base}.each do |file|
  require File.join(File.dirname(__FILE__), 'nikeplus', file)
end