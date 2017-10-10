Rails.application.routes.draw do
  root to: 'home#index'

  get 'users/current' => 'user#current'
  post 'users/login_token' => 'user#login_token'

  resources :users, controller: 'user', only: [:index, :create] do
    get 'movies' => 'user#get_movies'
    post 'movies' => 'user#add_movie'
    # TODO add favorite or toggle
    # TODO add watched or toggle
  end

  resources :movies, controller: 'movie', only: [:index, :show, :create]
end
