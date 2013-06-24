desc "Retrieve travel information from NS"
task :retrieve_travel_info => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  def open_url(url)
    Nokogiri::HTML(open(url, :http_basic_authentication => [ENV["USER_NAME_NS"], ENV["PASSWORD_NS"]]))
  end
  
    # Get travel information about traject
    info_url = 'http://webservices.ns.nl/ns-api-treinplanner?fromStation=Leiden&toStation=Den+Haag+HS&departure=true'
    info_doc = open_url(info_url)
    disruption_url = 'http://webservices.ns.nl/ns-api-storingen?station=Leiden+Centraal'
    disruption_doc = open_url(disruption_url)
    # Option to select first, second, ect journey
    journey_option = 1
      Train.create(
      # Travel information
      from_station: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/reisdeel/reisstop/naam").first.text,
      to_station: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/reisdeel/reisstop/naam").last.text,
      disruption_notification: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/melding/text").text,
      departure_delay: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/vertrekvertraging").text,
      arrival_delay: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/aankomstvertraging").text,
      planned_travel_time: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/geplandereistijd").text,
      actual_travel_time: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/actuelereistijd").text,
      planned_departure_time: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/geplandevertrektijd").text,
      actual_departure_time: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/actuelevertrekstijd").text,
      plannend_arrival_time: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/geplandeaankomsttijd").text,
      actual_arrival_time: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/actueleaankomsttijd").text,
      current_status: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/reisdeel[#{journey_option}]/status").text,
      track: info_doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/reisdeel/reisstop/spoor").first.text,
      # Disruption information
      #departure:
      datetime: disruption_doc.xpath("//storingen/ongepland/storing/datum").text,
      #station: 
      actual_disruption: disruption_doc.xpath("//storingen/gepland/storing/reden").text,
      unplanned_disruption: disruption_doc.xpath("//storingen/ongepland/storing/reden").text,
      #TODO: De disruption message is een CDATA node en wordt niet gelezen door Nokogiri
      message: disruption_doc.xpath("//storingen/ongepland/bericht").text,
      advice: disruption_doc.xpath("//storingen/gepland/storing/advies").text
      )  

      puts "Rake task: completed"
end