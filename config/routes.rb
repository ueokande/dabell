Rails.application.routes.draw do
  devise_for :users
  resources :messages, only: %i(index show create destroy)
end
