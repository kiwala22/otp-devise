Rails.application.routes.draw do
  # get 'verify/generate'
  # get 'verify/authenticate'
  # get 'public/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'public#index'

  match 'resend_verify' => "verify#generate", via: [:post]
  match 'new_verify' => "verify#new", via: [:get]
  match 'verify' => "verify#authenticate", via: [:put]
end
