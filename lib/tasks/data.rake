require "nokogiri"
require "open-uri"

namespace :data do
  desc "Scrape and update data from blogto"
  task update: :environment do

    date_urls = (Date.today..(Date.today + 10)).to_a.map do |date|
      "http://www.blogto.com/events/?date=" + date.to_s
    end

    date_urls.each do |date_url|
      puts "\nFetching #{date_url}..."

      events_links = Nokogiri::HTML(open(date_url)) 
                       .css(".events-item .event-name a")
                       .map{|x| "http://www.blogto.com" + x.attr('href') }

      events_links.map do |event_url|
        page = Nokogiri::HTML(open(event_url))
        begin
          if Event.where(title: page.css("h1.title").text, date: page.css(".info-eventdate").text.to_date).present?
            print "|" # alread exists in db
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
            print "|"
          end
        rescue => e
          puts "\n" + e.to_s
          puts event_url.to_s
        end
      end
    end

  end

end