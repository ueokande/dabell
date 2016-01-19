Rails.application.routes.draw do
  root to: 'rooms#show'

  devise_for :users
  resources :messages, only: %i(index show create destroy)

  mount ActionCable.server => '/cable'
end
