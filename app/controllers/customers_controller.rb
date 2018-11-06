class CustomersController < ApplicationController

  def index
    customers = Customer.all
    # render json: jsonify(customers), status: :ok
    render json: customers.as_json( only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count)
  end




  private

  def jsonify(customer)
    return customer_data.as_json( only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count])
  end


end
