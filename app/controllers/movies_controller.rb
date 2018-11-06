class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render json: movies.as_json( only: [:id, :title, :release_date])

  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: { id: movie.id, title: movie.title }
    else
      render_error(:bad_request, movie.errors.messages )
    end

  end

  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end

end
