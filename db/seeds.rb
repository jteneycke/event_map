require "nokogiri"
require "open-uri"
require "colored"
require "pry"


base_url = "http://www.blogto.com/events/"

day_base_url = "http://www.blogto.com/events/?date="

date_range = (Date.today..(Date.today + 10)).to_a.map(&:to_s)

date_urls = date_range.map{|url| day_base_url + url }

date_urls.each do |date_url|
  events_page = Nokogiri::HTML(open(date_url))

  events_links = events_page.css(".events-item .event-name a")
                            .map{|x| "http://www.blogto.com" + x.attr('href') }

  puts "\nFetching #{date_url}..."

  # find_or_create_by
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
      #binding.pry
    end
  end
end
