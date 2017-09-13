class UserController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :current, :update, :destroy]
  respond_to :json

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

  def get_movies
    render json: {status: 'OK', movies: current_user.users_movies.eager_load(:movies) }
  end

  def add_movie
    render json: {status: 'OK', movie: UsersMovie.create(user_id: current_user.id, movie_id: params[:movie_id]) }
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
    params.require(:user).permit!
  end

end
