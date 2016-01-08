Rails.application.routes.draw do
  root to: 'messages#index'

  devise_for :users
  resources :messages, only: %i(index show create destroy)
end
