class UserController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :current, :update, :destroy, :add_movie, :set_watched, :set_favorite, :get_all_movies, :get_other_movies, :remove_movie]
  respond_to :json

  def index
    users = []
    User.all.each do |user|
      users.push(user_secure(user))
    end
    render json: { users: users }
  end

  def show
    render json: { user: user_secure(User.find(params[:id])) }
  end

  def create
    user = User.create(users_params)
    if user.valid?
      render json: { user: user_secure(user) }
    else
      if user.errors[:username].any? && user.errors[:email].any?
        render json: { error: user.errors }, status: 420
      elsif user.errors[:email].any?
        render json: { error: user.errors }, status: 421
      else
        render json: { error: user.errors }, status: 422
      end
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  def update
    user = current_user

    if user.update(users_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def login_token
    user = User.find_by(username: login_params[:username]).try(:authenticate, params[:password])
    if user
      render json: { jwt: user.auth_token }
    else
      render json: { error: "No user found or wrong password" }, status: 401
    end
  end

  def get_movies
    movies = []
    user = User.find_by_id(params[:user_id])
    if user.nil?
      render json: { error: "No user found" }, status: 422
    else
      user.users_movies.each do |user_movie|
        movies.push(movie_user(user_movie))
      end
      render json: { movies: movies }
    end
  end

  def add_movie
    # TODO addign movie which doesn't exist
    user_movie = UsersMovie.create(user_id: current_user.id, movie_id: params[:movie_id])
    if user_movie.valid?
      render json: { movie: movie_user(user_movie) }
    else
      render json: { error: user_movie.errors }, status: 403
    end

  end

  def set_watched
    user_movie = UsersMovie.find_by(user_id: current_user.id, movie_id: params[:movie_id])
    if user_movie.nil?
      render json: { error: "Movie doesn't exist" }, status: 422
    else
      user_movie.watched = params[:watched]
      user_movie.save
      render json: { movie: movie_user(user_movie) }
    end
  end

  def get_other_movies
    movies = []
    user = User.find_by_id(current_user.id)
    if user.nil?
      render json: { error: "No user found" }, status: 422
    else
      ids = []
      user.users_movies.each do |user_movie|
        ids.push(user_movie.movie_id)
      end
      render json: { movies: Movie.all_except([ids]) }
    end
  end

  def get_all_movies
    movies = []
    user = User.find_by_id(current_user.id)
    if user.nil?
      render json: { error: "No user found" }, status: 422
    else
      puts user.users_movies.ids
      user.users_movies.each do |user_movie|
        movie = movie_user(user_movie)
        movies.push(movie)
      end
      ids = []
      user.users_movies.each do |user_movie|
        ids.push(user_movie.movie_id)
      end
      puts Movie.all_except([ids]).ids
      Movie.all_except([ids]).each do |movie|
        movie = movie.attributes.symbolize_keys
        movie[:owned] = false
        movies.push(movie)
      end
      render json: { movies: movies }
    end
  end

  def set_favorite
    user_movie = UsersMovie.find_by(user_id: current_user.id, movie_id: params[:movie_id])
    if user_movie.nil?
      render json: { error: "Movie doesn't exist" }, status: 422
    else
      user_movie.favorite = params[:favorite]
      user_movie.save
      render json: { movie: movie_user(user_movie) }
    end
  end

  def remove_movie
    user_movie = UsersMovie.find_by(user_id: current_user.id, movie_id: params[:movie_id])
    if user_movie.nil?
      render json: { error: "Movie doesn't exist" }, status: 422
    else
      movie = Movie.find(user_movie.movie_id)
      movie = movie.attributes.symbolize_keys
      movie[:owned] = false
      user_movie.destroy
      render json: { movie: movie }
    end
  end

  def current
    render json: current_user
  end

  private

  def users_params
    params.require(:user).permit(:username, :password, :email, :image)
  end

  def login_params
    params.permit(:username, :password)
  end

  def movie_user user_movie
    movie = Movie.find(user_movie.movie_id).attributes.symbolize_keys
    movie[:watched] = user_movie.watched
    movie[:favorite] = user_movie.favorite
    movie[:owned] = true
    return movie
  end

  def user_secure user
    new_user = user.attributes.symbolize_keys
    new_user.delete :password_digest
    return new_user
  end

end
