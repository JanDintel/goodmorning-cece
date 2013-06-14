desc "Retrieve weather from Buienrader"
task :retrieve_weather => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  
    url = 'http://xml.buienradar.nl'
    doc = Nokogiri::HTML(open(url))
    Weather.create(
      temperature: doc.xpath('//actueel_weer/weerstations/weerstation[@id=6210]/temperatuurgc').text.to_f,
      windspeed: doc.xpath('//actueel_weer/weerstations/weerstation[@id=6210]/windsnelheidms').text.to_f,
      date: doc.xpath('//actueel_weer/weerstations/weerstation[@id=6210]/datum').text,
      humidity: doc.xpath('//actueel_weer/weerstations/weerstation[@id=6210]/luchtvochtigheid').text.to_i
      )
  
    puts "Rake task: completed"
  end