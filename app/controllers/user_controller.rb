class UserController < ApplicationController
  before_action :set_user, only: [:get_movies, :add_movie, :toggle_watched, :toggle_favorite]

  def index
    # TODO don't send password
    render json: {status: 'OK', users: User.all }
  end

  def show
    render json: {status: 'OK', user: User.find(params[:id]) }
  end

  def create
    render json: {status: 'OK', user: User.create(users_params) }
  end

  def get_movies
    render json: {status: 'OK', movies: @user.users_movies.eager_load(:movies) }
  end

  def add_movie
    render json: {status: 'OK', movie: UsersMovie.create(user_id: @user.id, movie_id: params[:movie_id]) }
  end

  def toggle_watched
  end

  def toggle_favorite
  end

  private

  def users_params
    params.require(:user).permit!
  end

  def set_user
    @user = User.find(params[:user_id])
    puts @user.inspect
  end
end
