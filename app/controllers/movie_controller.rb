class MovieController < ApplicationController

  def index
    render json: {status: 'OK', movies: Movie.all }
  end

  def show
    render json: {status: 'OK', movie: Movie.find(params[:id]) }
  end

  def create
    render json: {status: 'OK', movie: Movie.create(movies_params) }
  end

  private

  def movies_params
    params.require(:movie).permit!
  end
end
