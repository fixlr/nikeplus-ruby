#!/bin/env ruby

require '../lib/nikeplus'

def generate_rss(builder, rss_title, rss_link, items)
  builder.rss('version' => '0.91') {
    builder.channel {
      builder.title rss_title
      builder.link  rss_link
      
      items.reverse.each do |item|
        builder.item {
          builder.title "#{item.startTime}"
          builder.description "This run was #{item.miles} miles and lasted #{item.minutes}'#{item.seconds}\"."
        }
      end
    }
  }
end

# Authenticate to access your private Nike+ user info
me = NikePlus.new('my@email.com', 'secretpassword')
my_runs = me.runs
builder = Builder::XmlMarkup.new

puts generate_rss(builder, "My Recent Runs", "http://petrock.org/runs.rss", me.runs)
