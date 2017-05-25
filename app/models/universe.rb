class Universe
  def self.discover_events
    # https://discover.universe.com/
    #   api/
    #     v2/
    #       discover_events?
    #         after=1495832400
    #         before=1496030399
    #         latitude=43.6383
    #         limit=18
    #         longitude=-79.4301
    party = HTTParty.get("https://discover.universe.com/api/v2/discover_events?after=1495832400&before=1496030399&latitude=43.6383&limit=18&longitude=-79.4301")

    list = party["discover_events"].first.keys





    # id
    # host_source_id
    # source_id
    # source_type

    # _score
    # featured_score

    # location
    # address
    # latitude
    # longitude

    # title
    # description
    # category
    # image_url

    # host_name
    # host_image_url
    # cover_photo_url

    # hide_date
    # formatted_duration
    # start_time
    # end_time

    # attending_count < Charge sliding rate based on scarcity of remaining?
    # multiple_rates  < How do ticket scalpers work?

    # formatted_price
    # currency
    # price
    # ticket_url



    # show_avatars_of_bookers

    binding.pry
  end


end
