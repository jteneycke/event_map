class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :address,
             :body,
             :image_url,
             :latitude,
             :longitude,
             :time,
             :title,
             :venue,
             :website

  def time
    object.time.strftime("%l:%M %p") if object.time?
  end

  def image_url
    object.image_url || ActionController::Base.helpers.asset_path("poster-icon.png")
  end

end
