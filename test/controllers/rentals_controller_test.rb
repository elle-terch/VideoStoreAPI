require "test_helper"

describe RentalsController do
  describe "index" do

    it "is a functioning route" do
      get rentals_path
      must_respond_with :success
    end

    it "returns json" do
      get rentals_path
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "returns an Array" do
      get rentals_path

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all of the rentals" do
      get rentals_path

      body = JSON.parse(response.body)
      body.length.must_equal Rental.count
    end

    it "returns rentals with exactly the required fields" do
      keys = %w(movie_id customer_id checkout checkin id).sort
      get rentals_path
      body = JSON.parse(response.body)
      body.each do |rental|
        rental.keys.sort.must_equal keys
      end
    end

    it "returns an empty array when there are no rentals" do
      Rental.destroy_all
      Movie.destroy_all
      Customer.destroy_all
      get rentals_path
      expect(Rental.count).must_equal 0
    end
  end


  describe "show" do
    it "can get a rental" do
      get rental_path(rentals(:one).id)
      must_respond_with :success
    end

    it "responds with not_found if no rental is found" do
      id = 3030489459834
      get rental_path(id)
      must_respond_with :not_found
    end
  end

  describe "checkout" do

    let (:rental_params) {
      {
        movie_id: Movie.first.id,
        customer_id: Customer.first.id,
        checkout: "2016-11-11"
      }
    }

    it "checks out a movie, given valid data " do

      expect {
        post checkout_path, params: { rental: rental_params }
      }.must_change "Rental.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash

      expect(body).must_include "id"
      rental = Rental.find(body["id"].to_i)

      must_respond_with :success

    end

    it "does not check out a movie if data is invalid" do

      rental_data = {
        rental: {
          movie_id: Movie.first.id,
          customer_id: Customer.first.id
        }
      }

      Rental.new(rental_data[:rental]).wont_be :valid?, "Book data wasn't invalid. Please come fix this test"

      expect {
        post(checkout_path, params: rental_data)
      }.wont_change('Rental.count')

      must_respond_with :bad_request

    end


  end

  describe "checkin" do
    it "can successfully update a rental with today's date as the checkin date" do
      rental = Rental.first


      # if the checking date is hardcoded like below, it works.  Otherwise, checkin date is nil?!!?
      # rental.checkin = Date.today

      patch checkin_path(rental.id)
      must_respond_with :success

      expect(rental.checkin).must_equal Date.today
    end


    it "responds with bad_request if no rental is found" do
      rental = Rental.last
      patch checkin_path(rental.id + 1)
      must_respond_with :bad_request
    end

  end

end
