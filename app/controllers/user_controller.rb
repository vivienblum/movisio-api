class UserController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :current, :update, :destroy]
  respond_to :json

  def index
    # TODO don't send password
    render json: {status: 'OK', users: User.all }
  end

  # DEPRECATED
  def show
    render json: {status: 'OK', user: User.find(params[:id]) }
  end

  def create
    render json: {status: 'OK', user: User.create(users_params) }
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
    user = User.find_by(username: login_params[:username])
    if !user.nil?
      if user.password == params[:password]
        render json: { jwt: user.auth_token }
      else
        render json: { error: "Wrong Password" }
      end
    else
      render json: { error: "No user found" }
    end
  end

  def get_movies
    # render json: {status: 'OK', movies: current_user.users_movies.eager_load(:movies) }
    # TODO get from params[:id]
    movies = []
    current_user.users_movies.each do |user_movie|
      movie = Movie.find(user_movie.movie_id).attributes.symbolize_keys
      movie[:watched] = user_movie.watched
      movie[:favorite] = user_movie.favorite
      movies.push(movie)
    end
    render json: {status: 'OK', movies: movies }
    # render json: {status: 'OK', movies: current_user.users_movies.includes(:movies) }
  end

  def add_movie
    # TODO disable duplicate
    user_movie = UsersMovie.create(user_id: current_user.id, movie_id: params[:movie_id])
    movie = Movie.find(user_movie.movie_id).attributes.symbolize_keys
    movie[:watched] = user_movie.watched
    movie[:favorite] = user_movie.favorite
    render json: {status: 'OK', movie: movie }
  end

  def toggle_watched
  end

  def toggle_favorite
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

end
