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

  # Don't think we need any of these below, but make some more API action could be good to show off.

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private

  def event_params
    params.require(:event).permit(:title, :body, :date, :time, :venue, :address, :website)
  end

end
