Rails.application.routes.draw do
  root to: 'rooms#show'

  devise_for :users
  resources :messages, only: %i(index show create destroy)
  resources :users, except: %i(show destroy edit)
  get 'users/edit', to: 'users#edit'

  mount ActionCable.server => '/cable'
end
