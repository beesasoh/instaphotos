Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    resources :comments, only: [:create, :update, :destroy]
  end

  get ':user_name', to: 'profile#show', as: :profile

  root 'posts#index'
end
