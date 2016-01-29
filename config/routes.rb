Rails.application.routes.draw do
  root to: 'rooms#show'

  devise_for :users
  resources :messages, only: %i(index show create destroy)
  resources :users, only: %i(index new create)

  mount ActionCable.server => '/cable'
end
