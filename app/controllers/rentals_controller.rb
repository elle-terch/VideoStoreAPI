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
    rental = Rental.find_by(id: params[:id])
    if rental
      rental.update(checkin: Date.today)
    else
      render json: { errors { rental_id: ["No such rental" ] } }
    end
  end



  if @book.update(book_params)
     flash[:success] = "Successfully updated book \"#{@book.title}\""
     redirect_to book_path(@book.id)
   else
     flash.now[:error] = "Invalid book data"
     render(:edit, status: :bad_request)
   end



  private

  def rental_params
    params.require(:rental).permit(:movie_id, :customer_id, :checkout )
  end

end
