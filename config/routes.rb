Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  
  resources :employees do
    resources :free_times, only: [:index]
  end

  resources :free_times

  devise_scope :user do
    post 'login', to: 'users/sessions#create'
    delete 'logout', to: 'users/sessions#destroy'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
