class HomeController < ApplicationController
  def index
    @date = if params[:date].present?
              DateTime.parse(params[:date])
            else
              DateTime.now
            end
  end
end
