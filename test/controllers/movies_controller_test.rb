describe MoviesController do
  describe "index" do

    it "is a functioning route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_path
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "returns an Array" do
      get movies_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(id title release_date).sort
      get movies_path
      body = JSON.parse(response.body)
      body.each do |movie|
        movie.keys.sort.must_equal keys
      end
    end

    it "returns an empty array when there are no movies" do
      Rental.destroy_all
      Movie.destroy_all
      get movies_path
      expect(Movie.count).must_equal 0
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "The Adventures of Priscilla Queen of the Desert",
        release_date: "1999",
        overview: "A good movie",
        inventory: 4
      }
    }

    it "creates a new movie given valid data" do
      expect {
      post movies_path, params: { movie: movie_data }
    }.must_change "Movie.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie_data[:title]
      must_respond_with :success
    end

    it "returns an error for invalid movie data" do

      movie_data["title"] = nil

      expect {
      post movies_path, params: { movie: movie_data }
    }.wont_change "Movie.count"

      must_respond_with :bad_request

    end

  end

  describe "show" do
    it "can get a movie" do
     get movie_path(movies(:dragon).id)
     must_respond_with :success
   end

   it "responds with not_found if no movie is found" do
     id = 3030489459834
     get movie_path(id)
     must_respond_with :not_found
   end
  end

end
