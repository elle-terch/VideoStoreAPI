class MoviesController < ApplicationController

  def index
    movies = Movie.all

    render json: jsonify(movies)

  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: { id: movie.id, title: movie.title }
    else
      render_error(:bad_request, movie.errors.messages )
    end
  end

  def show
    movie = Movie.find_by(id: params[:id])
    if movie
      render json: jsonify(movie)
    # else
      # render_error(:not_found, { mov})
    end
  end


  private

  def movie_params
    params.require(:movie).permit(:title, :overview, :release_date, :inventory)
  end

  def jsonify(movie_data)
    return movie_data.as_json( only: [:id, :title, :release_date] )
  end

end
