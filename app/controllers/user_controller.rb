class UserController < ApplicationController
  def index
    puts "ACTION INDEX"
    # TODO don't send password
    render json: {status: 'OK', users: User.all }
  end

  def show
    puts "ACTION SHOW"
    render json: {status: 'OK', user: User.find(params[:id]) }
  end

  def create
    puts "ACTION CREATE"
    render json: {status: 'OK', user: User.create(users_params) }
  end

  def get_movies
  end

  def add_movie
  end

  def toggle_watched
  end

  def toggle_favorite
  end

  private

  def users_params
    params.require(:user).permit!
  end
end
