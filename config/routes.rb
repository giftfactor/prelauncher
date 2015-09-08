Rails.application.routes.draw do
  get 'sessions/create'

  get 'sessions/failure'

  resources :users, only: [:new, :create]

  get '/auth/:provider/callback' => 'users#create'
  get '/auth/failure' => 'users#failure'

  get 'thank-you' => 'users#refer', as: "referrals"
  root to: 'users#new'
end
