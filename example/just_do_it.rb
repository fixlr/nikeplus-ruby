#!/bin/env ruby

require '../lib/nikeplus'

# Authenticate to access your private Nike+ user info
me = NikePlus.new('my@email.com', 'secretpassword')