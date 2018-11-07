require "test_helper"

describe Movie do


  describe 'validations' do

    it 'is valid when a title and inventory number are present' do

      @movie = Movie.new(title: 'title', inventory: 3)
      result = @movie.valid?

      expect(result).must_equal true

    end


    it 'is invalid without any inventory' do

      @movie = Movie.new(title: 'title')
      result = @movie.valid?

      expect(result).must_equal false
      expect(@movie.errors.messages).must_include :inventory

    end


    it 'is invalid without a title' do

      @movie = Movie.new(inventory: 2)
      result = @movie.valid?

      expect(result).must_equal false
      expect(@movie.errors.messages).must_include :title

    end


    it 'is invalid when missing both required fields' do

      @movie = Movie.new()
      result = @movie.valid?

      expect(result).must_equal false

    end


    it 'is invalid if inventory is not an integer' do

      @movie = Movie.new(title: 'title', inventory: 'abc')
      result = @movie.valid?

      expect(result).must_equal false
      expect(@movie.errors.messages).must_include :inventory

    end

  end

  describe "relations" do
    
    it "has a list of rentals" do
      movie = movies(:dragon)
      movie.must_respond_to :rentals

      movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end

    end

  end

end
