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

end
