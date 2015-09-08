Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  get 'thank-you' => 'users#refer', as: "referrals"
  root to: 'users#new'
end
