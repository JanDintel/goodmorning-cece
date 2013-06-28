desc "Retrieve birthdays from Facebook user"
task :retrieve_birthdays => :environment do
  require 'rubygems'
  require 'koala'
  require 'certified'

  oauth_token = ENV["OAUTH_TOKEN_FACEBOOK"]
  graph = Koala::Facebook::API.new(oauth_token)

  all_birthdays = graph.get_object("me?fields=id,name,friends.fields(birthday,name)")
  all_birthdays.reject {|birthday| birthday == nil }
  all_birthdays["friends"]["data"].each { |friend| friend[""] }.each do |friend|
    #TODO: Een functie die checkt of je niet alles dupliceert in de db
    Birthday.create(
      name: friend["name"],
      date: friend["birthday"],
      facebook_id: friend["id"]
      #user_id: current_user
      )
  end
  puts "Rake task: completed"
end