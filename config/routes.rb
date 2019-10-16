Rails.application.routes.draw do
  get 'welcome/index'
  get 'welcome/remove'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
