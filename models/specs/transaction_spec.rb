require("minitest/autorun")
require('minitest/rg')
require_relative("../customer")
require_relative("../drink")

class CustomerTest < MiniTest::Test

  def setup
    @drink = Drink.new("beer", 2.0, 5)
    @customer = Customer.new("Frodo", 10.0, 28, 0)
  end
