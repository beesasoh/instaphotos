Rails.application.routes.draw do
  
  devise_for :users
  resources :posts

  get ':user_name', to: 'profile#show', as: :profile

  root 'posts#index'
end
