require "nokogiri"
require "open-uri"
require "pry"
require "httparty"
require "ostruct"

namespace :data do
  desc "Scrape and update data from blogto"
  task update: :environment do


    #date_urls = (Date.today..(Date.today + 10)).to_a.map do |date|
      #"http://www.blogto.com/events/?date=" + date.to_s
    #end

    #resp = HTTParty.get("https://www.blogto.com/api/v2/events/", {
      #bundle_type: "medium",
      #date:        "2018-02-19",
      #limit:       9999,
      #offset:      0,
      #ordering:    "-start_date_time"
    #})

    date = "2018-02-19"

    body = HTTParty.get("https://www.blogto.com/api/v2/events/?bundle_type=medium&date=#{date}&limit=9999&offset=0&ordering=-start_date_time").body # => nil
    json = JSON.parse(body, object_class: OpenStruct)

    #binding.pry

    #{
      #"id"                   => 104193,
      #"title"                => "D-Beat Forever Fest // Night 3 - The Last Night",
      #"image_url"            => "https://media.blogto.com/events/2018/01/29/3a8650f0-4689-4229-a327-3d6537e3923e.png",
      #"share_url"            => "https://www.blogto.com/events/d-beat-forever-fest-night-3-the-last-night-toronto/",
      #"description_stripped" =>
      #"Come celebrate the life and friends of D-Beatstro for the last big party\nwith our dear friends\nRespire\nhttps://respirefamily.bandcamp.com/\nProm Nite\nhttps://realrockers.bandcamp.com/\nKaleidoscope Horse\nhttps://kaleidoscopehorse.bandcamp.com/\nDead Broke\nhttps://dead-broke.bandcamp.com/\nTongues\nhttps://www.facebook.com/uglytongues/\nLauren Boyko ( of Stick & Poke / Leaf Cheeks )\nhttps://stickandpoke.bandcamp.com/\n+ a few more\nPWYC ( donations to help pay down debts)\nalways all ages\n7pm",
        #"venue_name"         => "D-Beatstro",
        #"is_top_pick"        => true,
        #"can_be_bookmarked"  => true,
        #"start_time"         => "7:00 PM",
        #"all_day"            => false,
        #"end_time"           => "11:30 PM",
        #"listing"            =>
      #{
        #"id"             => 11349,
        #"name"           => "D-Beatstro",
        #"share_url"      => "https://www.blogto.com/restaurants/d-beatstro-toronto/",
        #"image_url"      => "https://media.blogto.com/listings/c883-20151229-dbeatstro590-11.jpg",
        #"date_published" => "2015-11-09T00:00:00",
        #"is_reviewed"    => true,
        #"date_reviewed"  => "2016-02-24T00:00:00"
      #}
    #}

    json["results"].each do |event|
      begin
        if Event.where({
            title:     event.title,
            blogto_id: event.id
        }).present?
          print "|" # alread exists in db
        else
          Event.create!({
            title:      event.title,
            body:       event.description_stripped,
            date:       date,
            start_time: event.start_time,
            end_time:   event.end_time,
            venue:      event.venue_name,
            address:    nil,
            website:    event.share_url,
            image_url:  event.image_url
          })
          print "|"
        end
      rescue => e
        puts "\n" + e.to_s
        puts event
        binding.pry
      end
    end

    #date_urls.each do |date_url|
      #puts "\nFetching #{date_url}..."

      #index_page =  Nokogiri::HTML(open(date_url))
      #events = index_page.css(".events-item").map do |event|
        #{
          #event_url: event.css(".event-name a").map{|x| "http://www.blogto.com" + x.attr('href') }.first,
          #image_url: event.css(".poster a img").map{|img| img.attr("src") }.first
        #}
      #end

      #events.each do |event|
        #page = Nokogiri::HTML(open(event[:event_url]))
        #begin
          #if Event.where(title: page.css("h1.title").text, date: page.css(".info-eventdate").text.to_date).present?
            #print "|" # alread exists in db
          #else
            #event = Event.create!(
              #title:    page.css("h1.title").text,
              #body:     page.css("#content-body").to_html,
              #date:     page.css(".info-eventdate").text.strip,
              #time:     page.css(".info-eventtime").text.strip,
              #venue:    page.css(".venue-name").text.strip,
              #address:  page.css(".location").text.strip,
              #website:  (page.css(".info-website").attr('href').value unless page.css(".info-website").empty?),
              #image_url: event[:image_url]
            #)
            #print "|"
          #end
        #rescue => e
          #puts "\n" + e.to_s
          #puts event[:event_url]
          #binding.pry
        #end
      #end
    #end

  end

end
