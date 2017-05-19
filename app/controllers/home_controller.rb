class HomeController < ApplicationController

  def index
    @date   = params[:date].present? ? DateTime.parse(params[:date]) : DateTime.now
    @events = Event.where(date: @date).all
  end

end
