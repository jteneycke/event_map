require "nokogiri"
require "open-uri"
require "colored"
require "pry"


base_url = "http://www.blogto.com/events/"
events_page = Nokogiri::HTML(open(base_url))

events_links = events_page.css(".events-item .event-name a")
                          .map{|x| "http://www.blogto.com" + x.attr('href') }

puts "Fetching events...".yellow

events_links.map do |event_url|
  page = Nokogiri::HTML(open(event_url))
  begin
    if Event.where(title: page.css("h1.title").text, date: page.css(".info-eventdate").text.to_date).present?
      print "|".yellow # alread exists in db
    else
      event = Event.create!(
        title:    page.css("h1.title").text,
        body:     page.css("#content-body").to_html,
        date:     page.css(".info-eventdate").text.strip,
        time:     page.css(".info-eventtime").text.strip,
        venue:    page.css(".venue-name").text.strip,
        address:  page.css(".location").text.strip,
        website:  (page.css(".info-website").attr('href').value unless page.css(".info-website").empty?)
      )
      print "|".green
    end
  rescue => e
    puts "\n" + e.to_s.red
    puts event_url.to_s.red
    binding.pry
  end
end
