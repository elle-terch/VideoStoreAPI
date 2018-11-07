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


  def checkout
    rental = Rental.new(rental_params)
    if rental.save
      render json: { id: rental.id }
      #should we be validating movie & customer ids?
    end
  end


  def checkin

  end

  private

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id )
  end

end
