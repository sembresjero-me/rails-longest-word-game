Rails.application.routes.draw do
  get 'new', to: 'games#new'
  get 'score', to: 'games#score'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
