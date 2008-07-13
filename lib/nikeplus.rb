require 'net/http'
require 'net/https'
require 'uri'
require 'rexml/document'
require 'cgi'

%w{base session http_response profile run_list run}.each do |file|
  require File.join(File.dirname(__FILE__), 'nikeplus', file)
end