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
    else
      render json: { errors: { rental_id: ["No such rental"] } }, status: :not_found
    end
  end


  def checkout
    rental = Rental.new(rental_params)
    if rental.save
      render json: { id: rental.id }
    else
      render json: {}, status: :bad_request
    end
  end


  def checkin
    rental_id = params[:id]
    rental = Rental.find_by(id: rental_id)

    if rental
      rental.update(checkin: Date.today)
      render json: { id: rental.id }
    else
      render json: { errors: { rental_id: ["No such rental"] } }, status: :bad_request
    end
  end




  private

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id, :checkout )
  end

end
