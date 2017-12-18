require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      resources :mgrs_grids
      resources :products
      resources :tiles
    end
  end

  get 'home/index'
  root 'home#index'
end
