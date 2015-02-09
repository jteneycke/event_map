class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :latitude, :longitude, :body

end
