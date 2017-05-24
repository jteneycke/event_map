class EventsController < ApplicationController

  def index
    @date = if params[:date].present?
              DateTime.parse(params[:date])
            else
              DateTime.now
            end
    @events = Event.where(date: @date).all
    render json: @events, each_serializer: EventSerializer
  end

  def show
    @event = Event.find(params[:id])
    render json: @event, serializer: EventSerializer
  end

end
