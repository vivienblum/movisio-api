Rails.application.routes.draw do
  root to: 'home#index'

  get 'users/current' => 'user#current'
  post 'users/login_token' => 'user#login_token'
  post 'users/movies' => 'user#add_movie'
  put 'users/movies/watched/:movie_id' => 'user#set_watched'
  put 'users/movies/favorite/:movie_id' => 'user#set_favorite'
  get 'users/movies/all' => 'user#get_all_movies'
  delete 'users/movies/:movie_id' => 'user#remove_movie'

  resources :users, controller: 'user', only: [:index, :create, :show] do
    get 'movies' => 'user#get_movies'
  end

  resources :movies, controller: 'movie', only: [:index, :show, :create]
end
