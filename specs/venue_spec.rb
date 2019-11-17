require('minitest/autorun')
require('minitest/reporters')
require_relative('../venue')
require_relative('../room')
require_relative('../guest')
require_relative('../song')
require_relative('../stock')
require('pry')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestVenue < Minitest::Test

  def setup
    @song1 = Song.new("Simply the Best", "Tina Turner")
    @song2 = Song.new("Turn Back Time", "Cher")
    @song3 = Song.new("It's All Coming Back", "Celine Dion")
    @song4 = Song.new("Shake It Off", "Taylor Swift")
    @song5 = Song.new("Can't Feel My Face", "The Weekend")
    @song6 = Song.new("Shape of You", "Ed Sheeran")
    @song7 = Song.new("My Heart Will Go On", "Celine Dion")

    @songs1 = [@song1, @song2, @song3, @song7]
    @songs2 = [@song4, @song5, @song6]

    @guest1 = Guest.new("Emma", 10.00, @song6)
    @guest2 = Guest.new("Matt", 20.00, @song5)
    @guest3 = Guest.new("Caroline", 15.00, @song2)
    @guest4 = Guest.new("Stephanie", 20.00, @song3)
    @guest5 = Guest.new("William", 20.00, @song3)
    @guest6 = Guest.new("Zack", 20.00, @song3)

    @guests = [@guest1, @guest2, @guest3, @guest4, @guest5]

    @room1 = Room.new("Power Ballads", @songs1, 5.00, 50.00)
    @room2 = Room.new("Chart Toppers", @songs2, 7.00)

    @rooms = [@room1, @room2]

    @stock1 = Stock.new("prosecco", 15.00, "drink")
    @stock2 = Stock.new("beer", 5.00, "drink")
    @stock3 = Stock.new("vodka", 3.00, "drink")
    @stock4 = Stock.new("nachos", 4.00, "food")
    @stock5 = Stock.new("pizza", 5.00, "food")
    @stock6 = Stock.new("chips", 3.00, "food")

    @stock = {
      @stock1 => 10,
      @stock2 => 50,
      @stock3 => 100,
      @stock4 => 20,
      @stock5 => 20,
      @stock6 => 40
    }

    @venue = Venue.new("Lucky Voice", @rooms, 100.00, @stock)
  end

  def test_venue_has_name
    assert_equal("Lucky Voice", @venue.name)
  end

  def test_number_of_rooms
    assert_equal(2, @venue.rooms.count)
  end

  def test_amount_in_bank_account
    assert_equal(100.00, @venue.bank_account)
  end

  def test_get_stock_level
    assert_equal(10, @venue.stock_level(@stock1))
  end

  def test_add_items_to_stock
    @venue.add_item(@stock1)
    @venue.add_item(@stock1)
    assert_equal(12, @venue.stock_level(@stock1))
  end

  def test_remove_item_from_stock
    @venue.remove_item(@stock1)
    assert_equal(9, @venue.stock_level(@stock1))
  end

  def test_get_money_received_amount_from_room
    assert_equal(50.00, @venue.rooms[0].money_received)
  end

  def test_transfer_money_from_room_to_bank_account
    @venue.transfer_money("Power Ballads")
    assert_equal(0, @venue.rooms[0].money_received)
    assert_equal(150.00, @venue.bank_account)
  end
# Restock prosecco from venue stock to room 1.
# Restock chips from venue stock to room 2.
  def test_transfer_stock_to_room
    @venue.restock_room(@stock1, @room1)
    @venue.restock_room(@stock6, @room2)
    assert_equal(9, @venue.stock_level(@stock1))
    assert_equal(1, @room1.stock_level_drinks(@stock1))
    assert_equal(1, @room2.stock_level_food(@stock6))
  end


end
