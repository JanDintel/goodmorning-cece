desc "Retrieve travel information from NS"
task :retrieve_travel_info => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  
    # Get travel information about traject
    info_url = 'http://webservices.ns.nl/ns-api-treinplanner?fromStation=Leiden&toStation=Den+Haag+HS&departure=true'
    doc = Nokogiri::HTML(open(info_url, :http_basic_authentication => [ENV["USER_NAME_NS"], ENV["PASSWORD_NS"]]))
    journey_option = 1
    first_journey = doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]")
      Train.create(
        from_station: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/reisdeel/reisstop/naam").first.text,
        to_station: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/reisdeel/reisstop/naam").last.text,
        # message:
        disruption_notification: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/melding/text").text,
        departure_delay: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/vertrekvertraging").text,
        arrival_delay: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/aankomstvertraging").text,
        planned_travel_time: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/geplandereistijd").text,
        actual_travel_time: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/actuelereistijd").text,
        planned_departure_time: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/geplandevertrektijd").text,
        actual_departure_time: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/actuelevertrekstijd").text,
        plannend_arrival_time: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/geplandeaankomsttijd").text,
        actual_arrival_time: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/actueleaankomsttijd").text,
        current_status: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/reisdeel[#{journey_option}]/status").text,
        track: doc.xpath("//reismogelijkheden/reismogelijkheid[#{journey_option}]/reisdeel/reisstop/spoor").first.text
        )  
  
    # Get disruption information
    disruption_url = 'http://webservices.ns.nl/ns-api-storingen?station=Leiden+Centraal'
    doc = Nokogiri::HTML(open(disruption_url, :http_basic_authentication => [ENV["USER_NAME_NS"], ENV["PASSWORD_NS"]]))
      Train.create(
        #departure:
        datetime: doc.xpath("//storingen/ongepland/storing/datum").text,
        #station: 
        actual_disruption: doc.xpath("//storingen/gepland/storing/reden").text,
        unplanned_disruption: doc.xpath("//storingen/ongepland/storing/reden").text,
        #message:
        advice: doc.xpath("//storingen/gepland/storing/advies").text
        )
      puts "Rake task: completed"
    end