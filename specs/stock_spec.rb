require('minitest/autorun')
require('minitest/reporters')
require_relative('../stock')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestStock < Minitest::Test

  def setup
    @stock1 = Stock.new("prosecco", 15.00, "drink")
    @stock2 = Stock.new("beer", 5.00, "drink")
    @stock3 = Stock.new("vodka", 3.00, "drink")
    @stock4 = Stock.new("nachos", 4.00, "food")
    @stock5 = Stock.new("pizza", 5.00, "food")
    @stock6 = Stock.new("chips", 3.00, "food")
  end

  def test_stock_name
    assert_equal("prosecco", @stock1.name)
  end

  def test_stock_price
    assert_equal(5.00, @stock2.price)
  end

end
