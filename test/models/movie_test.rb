require "test_helper"

describe Movie do


  describe 'validations' do

    it 'is valid when all fields are present' do

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

end
