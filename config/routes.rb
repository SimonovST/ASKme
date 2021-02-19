Rails.application.routes.draw do
  root 'users#index'

  resources :users, except: (:destroy)
  resources :session, only: [:new, :create, :destroy]
  resources :questions

  get 'sign_up' => 'users#new'
  get 'log_out' => 'session#destroy'
  get 'log_in' => 'session#new'
end
