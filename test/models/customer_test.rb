require "test_helper"

describe Customer do

  describe 'validations' do

    it 'is valid when given a customer name' do

      @customer = Customer.new(name: 'Carly')
      result = @customer.valid?

      expect(result).must_equal true

    end


    it 'is invalid without a given customer name' do

      @customer = Customer.new()
      result = @customer.valid?

      expect(result).must_equal false
      expect(@customer.errors.messages).must_include :name
    end

  end

  describe "relations" do

    it "has a list of rentals" do
      customer = customers(:sally)
      customer.must_respond_to :rentals

      customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end

    end

  end

end
