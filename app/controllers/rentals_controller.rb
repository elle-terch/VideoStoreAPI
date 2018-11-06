class RentalsController < ApplicationController

  def index

    rentals = Rental.all
    render json: rentals.as_json( except: [:created_at, :updated_at] )

  end

  def show
    rental_id = params[:id]
    rental = Rental.find_by(id: rental_id)
    if rental
      render json: rental.as_json( except: [:created_at, :updated_at] )
    end
  end
end
