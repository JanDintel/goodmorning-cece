desc "Retrieve travel information from NS"
task :retrieve_travel_info => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  
  url = 'http://xml.buienradar.nl'
  doc = Nokogiri::HTML(open(url))