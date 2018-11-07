require "test_helper"

describe Rental do


  describe 'validations' do

    it 'is valid when a checkout date is present' do
      movie = movies(:dragon)
      customer = customers(:harry)
      @rental = Rental.new(checkout: "2018-01-18", movie_id: movie.id, customer_id: customer.id)
      result = @rental.valid?

      expect(result).must_equal true

    end


    it 'is invalid without a checkout date' do
      movie = movies(:dragon)
      customer = customers(:harry)
      @rental = Rental.new(movie_id: movie.id, customer_id: customer.id)
      result = @rental.valid?

      expect(result).must_equal false

      expect(@rental.errors.messages).must_include :checkout

    end

  end

  describe "relations" do

    it 'must relate to a movie' do
      rental = rentals(:one)

      expect(rental).must_respond_to :movie
      expect(rental.movie).must_equal movies(:dragon)
    end

    it 'must relate to a customer' do
      rental = rentals(:one)

      expect(rental).must_respond_to :customer
      expect(rental.customer).must_equal customers(:harry)
    end

  end

end
