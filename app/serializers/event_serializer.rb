class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :latitude, :longitude, :body, :time, :venue, :address, :website, :image_url

  def time
    object.time.strftime("%l:%M %p") if object.time?
  end

  def image_url
    object.image_url || ActionController::Base.helpers.asset_path("poster-icon.png") 
  end

end
