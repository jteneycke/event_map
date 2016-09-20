require "que/web"

Rails.application.routes.draw do
  root 'home#index'

  resources :events
  mount Que::Web => "/que"
end
