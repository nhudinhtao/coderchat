Rails.application.routes.draw do

  get 'auth/:provider/callback' => 'sessions#callback'

  get 'friends/new'

  get 'friends/create'

  get 'friends/destroy'

  get 'messages/show'

  root "messages#index"
  resources :users do 
    resources :messages
    resources :friends
  end

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  post 'sessions/create', as: :submit_login

  resources :messages do
    collection do
      get :sent
      get :received
      get :has_been_read
    end
  end

  resources :friends
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
