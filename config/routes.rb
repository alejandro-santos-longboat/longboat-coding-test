Rails.application.routes.draw do
  root to: 'landing#login'
  post '/sessions/create' => 'sessions#create'
  post '/sessions/delete' => 'sessions#delete'
  get '/dashboard' => 'dashboard#index'
end
