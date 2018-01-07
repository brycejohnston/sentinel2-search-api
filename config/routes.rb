require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      #resources :mgrs_grids
      #resources :products
      resources :tiles
      get 'mgrs_grids/closest'
    end
  end

  mount Sidekiq::Web => '/sqj'

  get 'home/index'
  root 'home#index'
end
