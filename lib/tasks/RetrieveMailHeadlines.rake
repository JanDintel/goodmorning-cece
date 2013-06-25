desc "Retrieve mail headlines from Gmail"
task :retrieve_mail_headlines => :environment do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'net/https'

  # mail_url = Net::HTTP.new("https://mail.google.com/mail/feed/atom", 443)
  uri = URI.parse("https://mail.google.com/mail/feed/atom")
  # pem = File.read("certificate/googlecert.cer")

  # Appertly it raises no errors when I remove the cert en key option.

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  # http.cert = OpenSSL::X509::Certificate.new(pem)
  # http.key = OpenSSL::PKey::RSA.new(pem)
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(uri.request_uri)
  request.basic_auth(ENV["USER_NAME_GMAIL", ENV["PASSWORD_GMAIL")
  response = http.request(request)

  mail =  Nokogiri::XML(response.body)

  puts mail
end